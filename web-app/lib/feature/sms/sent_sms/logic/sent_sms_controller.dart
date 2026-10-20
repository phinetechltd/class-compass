import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/absent_student_model.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_body.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_report_model.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/user_list_for_sms_model.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/repository/sms_sent_repository.dart';
import 'package:class_compass/feature/sms/sms_template/controller/sms_template_controller.dart';

class SentSmsController extends GetxController implements GetxService{
  final SentSmsRepository sentSmsRepository;
  SentSmsController({required this.sentSmsRepository});



  bool isLoading = false;

  UserListForSmsModel? userListForSmsModel;
  Future<void> getUserListFoeSms(String type) async {
    Response? response = await sentSmsRepository.getUsersForSms(type);
    if(response != null && response.statusCode == 200){
      userListForSmsModel = UserListForSmsModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  AbsentStudentModel? absentStudentModel;
  Future<void> getAbsentStudentList(int classId, int sectionId, String date) async {
    Response? response = await sentSmsRepository.getDateWiseAbsentStudentForSms(classId, sectionId, date);
    if(response != null && response.statusCode == 200){
      absentStudentModel = AbsentStudentModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  void toggleSelectedUser(int index) {
    final userList = userListForSmsModel?.data;
    if (userList == null || userList.isEmpty) return;
    userList[index].selected = !(userList[index].selected ?? false);
    isAllSelected = userList.every((element) => element.selected == true);
    update();
  }

  bool isAllSelected = false;
  void toggleAllUser() {
    if (userListForSmsModel?.data == null) return;
    isAllSelected = !isAllSelected;
    for (var element in userListForSmsModel!.data!) {
      element.selected = isAllSelected;
    }
    update();
  }


  TextEditingController smsContentController = TextEditingController();
  void setPredefinedTemplate(){
    smsContentController.text = Get.find<SmsTemplateController>().selectedSmsTemplateItem?.description ?? "";
    update();
  }

  Future<void> sentSms(SentSmsBody body) async {
    Response? response = await sentSmsRepository.sentSms(body);
    if(response != null && response.statusCode == 200){
      Get.back();
      showCustomSnackBar("sms_sent_successfully".tr, isError: false);

    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> sendAbsentSms(List<int> students) async {
    Response? response = await sentSmsRepository.sendAbsentSms(students);
    if(response != null && response.statusCode == 200){
      toggleAllAbsentStudent();
      showCustomSnackBar("sms_sent_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<String> userTypesForSms = ["Student" , "Teacher" , "Staff", "Admin", "Parent"];
  String selectedUserType = "Student";
  void changeUserType(String value){
    selectedUserType = value;
    getUserListFoeSms(selectedUserType);
    update();
  }


  ApiResponse<SmsReportItem>? smsReportModel;
  Future<void> getSmsReport(int page) async {
    Response? response = await sentSmsRepository.sentSmsReport(page, Get.find<DatePickerController>().formatedDate, Get.find<DatePickerController>().formatedEndDate);
    if(response != null && response.statusCode == 200){
      final apiResponse = ApiResponse<SmsReportItem>.fromJson(response.body, (json) => SmsReportItem.fromJson(json));
      if(page == 1) {
        smsReportModel = apiResponse;
      }else{
        smsReportModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        smsReportModel?.data?.total = apiResponse.data?.total;
        smsReportModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  void toggleSelectedAbsentStudent(int index) {
    final userList = absentStudentModel?.data;
    if (userList == null || userList.isEmpty) return;
    userList[index].selected = !(userList[index].selected ?? false);
    isAllSelectedAllAbsentStudent = userList.every((element) => element.selected == true);
    update();
  }

  bool isAllSelectedAllAbsentStudent = false;
  void toggleAllAbsentStudent() {
    if (absentStudentModel?.data == null) return;
    isAllSelectedAllAbsentStudent = !isAllSelectedAllAbsentStudent;
    for (var element in absentStudentModel!.data!) {
      element.selected = isAllSelectedAllAbsentStudent;
    }
    update();
  }


}
