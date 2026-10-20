<?php

namespace Modules\Payroll\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Modules\Authentication\Models\User;
use Modules\Payroll\Models\UserPayroll;

class PayrollReportController extends Controller
{
    public function salaryStatementReport(Request $request): JsonResponse
    {
        $year = intval($request->year);
        $month = intval($request->month);
        if (! $year || ! $month) {
            return $this->responseError([], 'Invalid year or month.', 422);
        }

        try {
            $data = UserPayroll::select('payslip_salaries.*', 'user_payrolls.*', 'payments.*')
                ->join('payslip_salaries', 'payslip_salaries.user_id', 'user_payrolls.user_id')
                ->join('payments', 'payments.user_id', 'user_payrolls.user_id')
                ->whereYear('payslip_salaries.payment_date', $year)
                ->whereMonth('payslip_salaries.payment_date', $month)
                ->with('user')
                ->get();

            if ($data && count($data) > 0) {
                return $this->responseSuccess($data, _lang('Payroll report successfully.'));
            }

            return $this->responseError([], 'No Data Found', 404);
        } catch (\Exception $e) {
            return $this->responseError([], 'Something went wrong.');
        }
    }

    public function getPaymentInfo(Request $request): JsonResponse
    {
        $fromDate = $request->from_date ?? date('Y-m-01');
        $toDate = $request->to_date ?? date('Y-m-t');

        try {
            $fromDate = Carbon::createFromFormat('Y-m-d', $fromDate)->startOfDay();
            $toDate = Carbon::createFromFormat('Y-m-d', $toDate)->endOfDay();
        } catch (\Exception $e) {
            return $this->responseError([], 'Invalid date format.');
        }

        $users = User::query()
            ->whereIn('user_type', [
                'Staff',
                'Teacher',
                'Accountant',
                'Librarian',
                'Hostel',
                'Transport',
            ])
            ->select('id', 'name')
            ->with([
                'payroll:id,user_id,net_salary,current_due,current_advance',
                'payroll.payslipSalaries' => function ($q) use ($fromDate, $toDate) {
                    $q->whereBetween('payment_date', [$fromDate, $toDate])
                        ->latest('payment_date');
                },
                'payroll.payslipSalaries.payments' => function ($q) use ($fromDate, $toDate) {
                    $q->whereBetween('created_at', [$fromDate, $toDate])
                        ->select('id', 'payslip_salary_id', 'type');
                },
                'payroll.payslipSalaries.invoice:id,invoice_id',
            ])
            ->get();

        $report = $users->map(function ($user) {
            $payroll = $user->payroll;
            $payslipSalary = $payroll?->payslipSalaries?->first();
            $netSalary = $payroll->net_salary ?? 0;
            $paidAmount = $payslipSalary->paid_amount ?? 0;

            return [
                'hr_id' => $user->id,
                'hr_name' => $user->name,
                'invoice_id' => $payslipSalary?->invoice?->invoice_id,
                'is_paid' => $payslipSalary?->is_paid,
                'payment_type' => $payslipSalary?->payments?->first()?->type,
                'net_salary' => $netSalary,
                'payable_salary' => $netSalary - $paidAmount,
                'paid' => $paidAmount,
                'due' => $payroll->current_due ?? 0,
                'advance' => $payroll->current_advance ?? 0,
                'payment_date' => $payslipSalary?->payment_date,
            ];
        });

        if ($report->isNotEmpty()) {
            return $this->responseSuccess(
                $report,
                _lang('HR Payments fetched successfully.')
            );
        }

        return $this->responseError([], 'No Data Found', 404);
    }
}
