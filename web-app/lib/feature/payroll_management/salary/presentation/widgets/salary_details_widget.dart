import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PayrollDetailsWidget extends StatelessWidget {
  final PayrollUser? payrollUser;

  const PayrollDetailsWidget({super.key, this.payrollUser});

  @override
  Widget build(BuildContext context) {
    if (payrollUser == null) {
      return const Center(child: Text("No Payroll Data"));
    }

    final heads = payrollUser!.payslipSalary;

    if (heads == null || heads.isEmpty) {
      return const Center(child: Text("No Salary Details"));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: heads.length,
      separatorBuilder: (_, __) => const SizedBox(height: Dimensions.paddingSizeSmall),
      itemBuilder: (_, index) {
        final head = heads[index];

        return CustomContainer(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Head Name + Paid Amount
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        head.paidAmount ?? "Unknown", // use model's name
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                      Text(
                        head.paidAmount ?? "0.00",
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // Paid Amount label
                Text(
                  "${"paid_amount".tr}: ${head.paidAmount ?? "0.00"}",
                  style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}