import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/domain/model/payroll_assign_model.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/domain/model/payroll_body.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/domain/repository/payroll_assign_repository.dart';

class PayrollAssignController extends GetxController implements GetxService {

  final PayrollAssignRepository payrollAssignRepository;

  PayrollAssignController({required this.payrollAssignRepository});

  PayrollAssignModel? payrollAssignModel;

  final Map<int, Map<int, TextEditingController>> textControllers = {};

  Future<void> getPayrollAssign() async {

    Response? response = await payrollAssignRepository.getPayrollAssign();

    if (response?.statusCode == 200) {
      payrollAssignModel = PayrollAssignModel.fromJson(response?.body);
      _initControllers();
    } else {
      ApiChecker.checkApi(response!);
    }

    update();
  }

  void _initControllers() {

    textControllers.clear();

    for (var user in payrollAssignModel?.data ?? []) {

      int userId = user.user?.id ?? 0;

      textControllers[userId] = {};

      for (var head in user.salaryHeadUserPayrolls ?? []) {

        int headId = head.salaryHeadId ?? 0;

        textControllers[userId]![headId] = TextEditingController(
          text: (head.amount ?? 0).toString(),
        );
      }
    }
  }

  void updateAmount(int userId, int headId, String value) {

    final parsed = double.tryParse(value) ?? 0.0;

    final user = payrollAssignModel?.data
        ?.firstWhereOrNull((e) => e.user?.id == userId);

    final payroll = user?.salaryHeadUserPayrolls
        ?.firstWhereOrNull((e) => e.salaryHeadId == headId);

    if (payroll != null) {
      payroll.amount = parsed;
    }
  }

  Future<void> createPayrollAssign() async {

    if (payrollAssignModel == null) return;

    PayrollAssignBody body = PayrollAssignBody(
      users: payrollAssignModel!.data?.map((user) {

        return Users(
          userId: user.user?.id ?? 0,
          salaryHeads: user.salaryHeadUserPayrolls?.map((head) {

            return SalaryHeadItem(
              salaryHeadId: head.salaryHeadId ?? 0,
              amount: head.amount?.toString() ?? "0",
            );

          }).toList(),
        );

      }).toList(),
    );

    Response? response =
    await payrollAssignRepository.createPayrollAssign(body);

    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
    } else {
      ApiChecker.checkApi(response!);
    }
  }
}