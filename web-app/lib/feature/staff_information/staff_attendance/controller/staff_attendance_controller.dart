
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/staff_attendance_body.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/staff_attendance_report_model.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/user_model.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/repository/staff_attendance_repository.dart';

class StaffAttendanceController extends GetxController implements GetxService{
  final StaffAttendanceRepository staffAttendanceRepository;
  StaffAttendanceController({required this.staffAttendanceRepository});




  bool isLoading = false;
  UserModel? userModel;
  Future<void> getStaffListForAttendance(String type) async {
    isLoading = true;
    update();
    Response? response = await staffAttendanceRepository.getStaffListForAttendance(type);
    if (response?.statusCode == 200) {
      userModel = UserModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> createStaffAttendance(StaffAttendanceBody body) async {
    isLoading = true;
    update();
    Response? response = await staffAttendanceRepository.createStaffAttendance(body);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  List<String> staffTypes = [ "Teacher" , "Staff", "Admin"];
  String? selectedStaffType;
  void setSelectedStaffType(String type){
    selectedStaffType = type;
    update();
  }



  List<String> presentTypeList = ["present", "absent", "leave"];
  int selectedPresentTypeIndex = -1;

  void setPresentType(int index, int employeeIndex){
    selectedPresentTypeIndex = index;
    userModel?.data?[employeeIndex].presentType = presentTypeList[index];
    update();
  }

  void setClockInTime(String time, int index){
    userModel?.data?[index].checkIn = time;
    update();
  }

  void setClockOutTime(String time, int index){
    userModel?.data?[index].checkOut = time;
    update();
  }


  String timeOfDayTo24Hour(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0'); // Ensures 2-digit hours
    final minutes = timeOfDay.minute.toString().padLeft(2, '0'); // Ensures 2-digit minutes
    return '$hours:$minutes';
  }


  TimeOfDay selectedTime = const TimeOfDay(hour: 09, minute: 00);
  TimeOfDay selectedCheckoutTime = const TimeOfDay(hour: 05, minute: 00);
  Future<void> pickTime(int index,{bool checkOut = false}) async {
    final TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
      },
    );
    if (time != null && time != selectedTime ) {
      if(checkOut){
        selectedCheckoutTime = time;
        userModel?.data?[index].checkOut = timeOfDayTo24Hour(selectedCheckoutTime);
      }else{
        selectedTime = time;
        userModel?.data?[index].checkIn = timeOfDayTo24Hour(selectedTime);
      }

    }
    update();

  }

  StaffAttendanceReportModel? staffAttendanceReportModel;
  Future<void> getStaffAttendanceReport({String? fromDate, String? toDate}) async {
    isLoading = true;
    update();
    Response? response = await staffAttendanceRepository.staffAttendanceReport(
        fromDate: fromDate, toDate: toDate);
    if (response != null && response.statusCode == 200) {
      staffAttendanceReportModel = StaffAttendanceReportModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }
  
}