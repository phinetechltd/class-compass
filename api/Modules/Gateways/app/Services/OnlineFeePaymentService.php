<?php

namespace Modules\Gateways\Services;

use App\Traits\StudentCollectionTrait;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Modules\Academic\Models\StudentSession;
use Modules\Accounting\Models\AccountingLedger;
use Modules\Authentication\Models\User;
use Modules\Finance\Models\Fee;
use Modules\Finance\Models\StudentCollectionDetailsSubHead;
use Modules\Gateways\Models\PaymentRequest;
use Throwable;

/**
 * Online fee payments made by parents/students (M-Pesa STK push or Paystack).
 *
 * The amount owed is always computed on the server; a confirmed payment is posted into the
 * normal student collection (invoice + accounting voucher), exactly like a cashier's quick
 * collection, so reports and balances stay correct.
 */
class OnlineFeePaymentService
{
    use StudentCollectionTrait;

    public const TYPE = 'fee_payment';

    /**
     * Unpaid fee heads for a student with the amounts the collection needs.
     */
    public function unpaidFeeHeads(int $studentId): array
    {
        $session = StudentSession::with('student')->where('student_id', $studentId)->first();
        if (! $session || ! $session->student) {
            return [];
        }

        $fees = Fee::with('feeHead.feeSubHeads')
            ->where('class_id', $session->class_id)
            ->where('section_id', $session->section_id)
            ->get();

        $heads = [];
        foreach ($fees as $fee) {
            $feeHead = $fee->feeHead;
            if (! $feeHead || isset($heads[$feeHead->id])) {
                continue;
            }

            $unpaidSubHeads = [];
            $alreadyPaid = 0.0;
            foreach ($feeHead->feeSubHeads ?? [] as $subHead) {
                $paid = (float) StudentCollectionDetailsSubHead::where('student_id', $studentId)
                    ->where('session_id', $session->session_id)
                    ->where('fee_head_id', $feeHead->id)
                    ->where('sub_head_id', $subHead->id)
                    ->sum('paid_amount');
                if ($paid < (float) $fee->fee_amount) {
                    $unpaidSubHeads[] = ['id' => $subHead->id, 'name' => $subHead->name, 'paid' => $paid];
                    $alreadyPaid += $paid;
                }
            }
            if (! $unpaidSubHeads) {
                continue;
            }

            $amounts = $this->getCollectionAmountsByFeeHeadAndSubHeads($studentId, $feeHead->id, array_column($unpaidSubHeads, 'id'));
            // The shared calculator charges each unpaid sub head in full; subtract part payments.
            $payable = round(max(0, (float) $amounts['fee_and_fine_payable'] - $alreadyPaid), 2);
            if ($payable <= 0) {
                continue;
            }

            $heads[$feeHead->id] = [
                'fee_head_id' => $feeHead->id,
                'fee_head_name' => $feeHead->name,
                'sub_heads' => $unpaidSubHeads,
                'sub_head_ids' => array_column($unpaidSubHeads, 'id'),
                'waiver' => (float) $amounts['waiver'],
                'fine_payable' => (float) $amounts['fine_payable'],
                'fee_payable' => round(max(0, (float) $amounts['fee_payable'] - $alreadyPaid), 2),
                'fee_and_fine_payable' => $payable,
                'total_payable' => $payable,
            ];
        }

        return array_values($heads);
    }

    public function totalDue(array $feeHeads): float
    {
        return round(array_sum(array_column($feeHeads, 'fee_and_fine_payable')), 2);
    }

    public function additionalData(PaymentRequest $payment): array
    {
        return json_decode($payment->additional_data ?? '[]', true) ?: [];
    }

    public function saveAdditionalData(PaymentRequest $payment, array $changes): void
    {
        $payment->additional_data = json_encode(array_merge($this->additionalData($payment), $changes));
        $payment->save();
    }

    /**
     * Mark the payment as paid and post it to the student's fee collection. Safe to call more
     * than once (callback, status poll and webhook can all arrive): only the first call posts.
     */
    public function confirm(string $paymentId, float $paidAmount, string $reference, array $extra = []): ?PaymentRequest
    {
        return DB::transaction(function () use ($paymentId, $paidAmount, $reference, $extra) {
            $payment = PaymentRequest::whereKey($paymentId)->lockForUpdate()->first();
            if (! $payment) {
                return null;
            }
            if ($payment->is_paid) {
                return $payment;
            }

            $payment->is_paid = 1;
            $payment->transaction_id = $reference;
            $this->saveAdditionalData($payment, array_merge($extra, [
                'status' => 'paid',
                'paid_amount' => $paidAmount,
                'paid_at' => now()->toDateTimeString(),
            ]));

            if ($payment->payment_type === self::TYPE) {
                try {
                    $collectionId = $this->postCollection($payment, $paidAmount, $reference);
                    $this->saveAdditionalData($payment, ['collection_id' => $collectionId]);
                } catch (Throwable $e) {
                    // Money was received: keep the payment as paid and flag it for the bursar.
                    report($e);
                    $this->saveAdditionalData($payment, ['posting_error' => $e->getMessage()]);
                }
            }

            return $payment;
        });
    }

    public function fail(PaymentRequest $payment, string $reason): void
    {
        if (! $payment->is_paid) {
            $this->saveAdditionalData($payment, ['status' => 'failed', 'result_desc' => $reason]);
        }
    }

    private function postCollection(PaymentRequest $payment, float $paidAmount, string $reference): ?int
    {
        $data = $this->additionalData($payment);
        $studentId = (int) $payment->attribute_id;
        $payer = User::find($data['payer_user_id'] ?? null);
        if (! $payer) {
            throw new \RuntimeException('Payer account not found; post this payment manually.');
        }

        // The collection code reads the institute/branch from the logged-in user.
        $previousUser = Auth::user();
        Auth::setUser($payer);

        try {
            // Use the live balance at confirmation time, allocated oldest fee head first.
            $feeHeads = $this->unpaidFeeHeads($studentId) ?: ($data['fee_heads'] ?? []);
            $remaining = $paidAmount;
            $lines = [];
            $totalPayable = 0;
            foreach ($feeHeads as $head) {
                $totalPayable += $head['fee_and_fine_payable'];
                $paid = min($remaining, $head['fee_and_fine_payable']);
                $remaining = round($remaining - $paid, 2);
                $lines[] = array_merge($head, ['total_paid' => $paid]);
            }
            if (! $lines) {
                throw new \RuntimeException('No unpaid fees found for this student; the payment was kept as a credit.');
            }

            $ledgerId = AccountingLedger::where('institute_id', $payment->institute_id)
                ->where('branch_id', $payment->branch_id)
                ->orderByRaw("ledger_name = 'Digital Payment' desc, accounting_category_id = 1 desc")
                ->value('id');

            $method = $payment->payment_method === 'mpesa' ? 'M-Pesa' : ucfirst((string) $payment->payment_method);
            $collection = $this->createCollectionApi([
                'student_id' => $studentId,
                'fee_heads' => $lines,
                'total_payable' => $totalPayable,
                'total_paid' => min($paidAmount, $totalPayable),
                'date' => now()->toDateString(),
                'attendance_fine' => 0,
                'quiz_fine' => 0,
                'lab_fine' => 0,
                'tc_amount' => 0,
                'note' => mb_substr("Online payment via {$method}. Ref {$reference}", 0, 190),
                'ledger_id' => $ledgerId,
            ]);

            return $collection?->id;
        } finally {
            if ($previousUser) {
                Auth::setUser($previousUser);
            } else {
                Auth::forgetUser();
            }
            Log::info('Online fee payment posted', ['payment_id' => $payment->id, 'reference' => $reference]);
        }
    }
}
