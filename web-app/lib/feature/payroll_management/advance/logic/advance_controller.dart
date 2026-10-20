import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_body.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/repository/advance_repository.dart';

class AdvanceController extends GetxController implements GetxService {
  final AdvanceRepository advanceRepository;
  AdvanceController({required this.advanceRepository});

  AdvanceSalaryModel? advanceSalaryModel;
  EmployeeModel? employeeModel;

  Future<void> getAdvanceSalaryList(int page) async {
    Response? response = await advanceRepository.getAdvanceSalaryList(page);
    if (response?.statusCode == 200) {
      if (page == 1) {
        advanceSalaryModel = AdvanceSalaryModel.fromJson(response?.body);
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> getEmployeeList() async {
    Response? response = await advanceRepository.getEmployeeList();
    if (response?.statusCode == 200) {
      employeeModel = EmployeeModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool loading = false;
  Future<void> createAdvanceSalary(AdvanceSalaryBody advanceSalaryBody) async {
    loading = true;
    update();
    Response? response = await advanceRepository.createAdvanceSalary(advanceSalaryBody);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> editAdvanceSalary(AdvanceSalaryBody advanceSalaryBody, int id) async {
    loading = true;
    update();
    Response? response = await advanceRepository.updateAdvanceSalary(advanceSalaryBody, id);
    if (response!.statusCode == 200) {
      loading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      loading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deleteAdvanceSalary(int id) async {
    Response? response = await advanceRepository.deleteAdvanceSalary(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAdvanceSalaryList(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  List<String> statusList = ["pending", "approved", "rejected"];
  String? selectedStatus;
  DateTime selectedDate = DateTime.now();
  String formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";


}
  