
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/routine_management/class_routine/domain/models/class_routine_body.dart';
import 'package:class_compass/feature/routine_management/class_routine/domain/models/classs_routine_model.dart';
import 'package:class_compass/feature/routine_management/class_routine/domain/repository/class_routine_repository.dart';


class ClassRoutineController extends GetxController implements GetxService{
  final ClassRoutineRepository classRoutineRepository;
  ClassRoutineController({required this.classRoutineRepository});




  bool isLoading = false;
  ClassRoutineModel? classRoutineModel;
  List<DAY>?  sat;
  List<DAY>?  sun;
  List<DAY>?  mon;
  List<DAY>?  tue;
  List<DAY>?  wed;
  List<DAY>?  thu;
  List<DAY>?  fri;
  Future<void> getClassRoutineList(int classId, int sectionId) async {
    Response? response = await classRoutineRepository.getClassRoutine(classId, sectionId);
    if (response?.statusCode == 200) {
      classRoutineModel = ClassRoutineModel.fromJson(response?.body!);
        sat = classRoutineModel?.data?.sATURDAY;
        sun = classRoutineModel?.data?.sUNDAY;
        mon = classRoutineModel?.data?.mONDAY;
        tue = classRoutineModel?.data?.tUESDAY;
        wed = classRoutineModel?.data?.wEDNESDAY;
        thu = classRoutineModel?.data?.tHURSDAY;
        fri = classRoutineModel?.data?.fRIDAY;
      selectDay(getToday());
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  String getToday(){
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

  String formatTimeToAmPm(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  }

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String selectedDay = "Monday";
  void selectDay(String day) {
    selectedDay = day;
    update();
  }

  TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay selectedCheckoutTime = const TimeOfDay(hour: 17, minute: 0);

  /// Pick time for start or end
  Future<void> pickTime({bool checkOut = false}) async {
    final TimeOfDay initial = checkOut ? selectedCheckoutTime : selectedTime;

    final TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: initial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (time != null) {
      if (checkOut) {
        selectedCheckoutTime = time;
      } else {
        selectedTime = time;
      }
      update(); // refresh UI
    }
  }

  /// Convert TimeOfDay → 24-hour string for API
  String formatTimeForApi(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  /// Convert TimeOfDay → readable AM/PM format for UI
  String formatTimeForDisplay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  Future<void> addNewClassRoutine(ClassRoutineBody body) async{
    Response? response = await classRoutineRepository.addNewClassRoutine(body);
    if(response?.statusCode == 200){
     showCustomSnackBar("added_successfully".tr, isError: false);
     getClassRoutineList(Get.find<ClassController>().selectedClassItem?.id??0, Get.find<SectionController>().selectedSectionItem?.id??0);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

}