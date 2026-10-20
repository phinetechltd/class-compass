<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountingLedger;

class AccountingLedgerTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $ledgers = [
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 1,
                'accounting_group_id' => 1,
                'ledger_name' => 'Cash',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 1,
                'accounting_group_id' => 2,
                'ledger_name' => 'Digital Payment',
                'balance' => 0.00,
            ],
            // Liabilities
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 2,
                'accounting_group_id' => 3,
                'ledger_name' => 'Accounts Payable',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 2,
                'accounting_group_id' => 3,
                'ledger_name' => 'Tuition Fee Refund',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 3,
                'accounting_group_id' => 4,
                'ledger_name' => 'Director`s Loan ',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 4,
                'accounting_group_id' => 5,
                'ledger_name' => 'Opening Balance Equity',
                'balance' => 0.00,
            ],

            // Fees Related Income -> Income From Fees
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Admission Fees Collection',
                'balance' => 75000.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Board Fees Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Dairy And Syllabuss Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Exam Fees Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Fee Collections Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Session Charge Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Study Materials Fees Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'TC Fees Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Testimonial Fees Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Tie And Id Card Collection',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 6,
                'ledger_name' => 'Tuition Fees Collection',
                'balance' => 27000.00,
            ],

            // Fees Related Income -> Income From Fine
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Attendance Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Quiz Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Lab Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Tuition Fee Fin',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Late Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Attendance Make up Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Laboratories Class Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'ID Card Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Discipline Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Library Fine',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 5,
                'accounting_group_id' => 7,
                'ledger_name' => 'Miscellaneous Fine',
                'balance' => 0.00,
            ],

            // Others Income
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 8,
                'ledger_name' => 'House Rent(Cr)',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 9,
                'ledger_name' => 'Old Paper Sells',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 10,
                'ledger_name' => 'Online Apply Fee',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 6,
                'accounting_group_id' => 11,
                'ledger_name' => 'Opening Balance',
                'balance' => 0.00,
            ],

            // General Expenses
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 12,
                'ledger_name' => 'Advertisement',
                'balance' => 0.00,
            ],

            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Anual Sports',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'National Day &amp; Fastival Expanse',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Ocation',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 13,
                'ledger_name' => 'Study Tour',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 14,
                'ledger_name' => 'Bank Charges',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Board Fee',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Miscellaneous Exp.',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 15,
                'ledger_name' => 'Office Expense',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 16,
                'ledger_name' => 'Conveyance Expenses',
                'balance' => 0.00,
            ],

            // 17
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Electricity Bill',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Internet Bill',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 17,
                'ledger_name' => 'Mobile Recharge Exp.',
                'balance' => 0.00,
            ],

            // 18
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 18,
                'ledger_name' => 'Entertainment Exp.',
                'balance' => 0.00,
            ],

            // 19
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 19,
                'ledger_name' => 'Exam Centre Fee',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 19,
                'ledger_name' => 'Exam Expenses',
                'balance' => 0.00,
            ],

            // 20
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 20,
                'ledger_name' => 'House Rent',
                'balance' => 0.00,
            ],

            // 21
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 21,
                'ledger_name' => 'Netizen Bill Payment',
                'balance' => 0.00,
            ],

            // 22
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 22,
                'ledger_name' => 'Office Stationary',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 22,
                'ledger_name' => 'Printing & Stationary Expense',
                'balance' => 0.00,
            ],

            // 23
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 23,
                'ledger_name' => 'Repair Expenses',
                'balance' => 0.00,
            ],

            // 24
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 24,
                'ledger_name' => 'Salary & Honorarium (Bank Payment)',
                'balance' => 0.00,
            ],
            [
                'institute_id' => 1,
                'branch_id' => 1,
                'accounting_category_id' => 7,
                'accounting_group_id' => 24,
                'ledger_name' => 'Salary & Honorarium (Cash Payment)',
                'balance' => 0.00,
            ],
        ];

        AccountingLedger::insert($ledgers);
    }
}
