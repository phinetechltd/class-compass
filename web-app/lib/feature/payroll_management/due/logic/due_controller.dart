import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/payroll_management/due/domain/model/due_model.dart';
import 'package:class_compass/feature/payroll_management/due/domain/model/due_payment_body.dart';
import 'package:class_compass/feature/payroll_management/due/domain/repository/due_repository.dart';

class DueController extends GetxController implements GetxService {
  final DueRepository dueRepository;
  DueController({required this.dueRepository});

  DueModel? dueModel;
  Future<void> getDue() async {
    Response? response = await dueRepository.getDue();
    if (response?.statusCode == 200) {
      dueModel = DueModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> duePayment(DuePaymentBody body) async {
    loading  = true;
    update();
    Response? response = await dueRepository.duePayment(body);
    if (response?.statusCode == 200) {
      Get.back();
      showCustomSnackBar("payment_successful".tr, isError: false);
      getDue();
    } else {
      ApiChecker.checkApi(response!);
    }
    loading = false;
    update();
  }
}
  