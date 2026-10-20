
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/routine_management/exam_routine/domain/model/exam_routine_body.dart';
import 'package:class_compass/feature/routine_management/exam_routine/domain/model/exam_routine_model.dart';
import 'package:class_compass/feature/routine_management/exam_routine/domain/repository/exam_routine_repository.dart';

class ExamRoutineController extends GetxController implements GetxService{
  final ExamRoutineRepository examRoutineRepository;
  ExamRoutineController({required this.examRoutineRepository});

  ExamRoutineModel? examRoutineModel;
  List<ExamRoutineItemBody>? examRoutineItemBodyList;

  Future<void> getExamRoutineList(int classId, int examId, int groupId) async {
    isLoading = true;
    update();
    Response? response = await examRoutineRepository.getExamRoutineList(classId, examId, groupId);
    if(response?.statusCode == 200){
      examRoutineModel = ExamRoutineModel.fromJson(response?.body);
      examRoutineItemBodyList = [];

      if(examRoutineModel != null && examRoutineModel!.data != null && examRoutineModel!.data!.isNotEmpty)
      {
        for(int i = 0; i < examRoutineModel!.data!.length; i++){
        examRoutineItemBodyList!.add(ExamRoutineItemBody(
          subjectId: examRoutineModel!.data![i].subjectId!,
          subjectName: examRoutineModel!.data![i].subjectName??'',
          dateController: TextEditingController(text: sanitize(examRoutineModel?.data?[i].date)),
          startTimeController: TextEditingController(text: sanitize(examRoutineModel?.data?[i].startTime)),
          endTimeController: TextEditingController(text: sanitize(examRoutineModel?.data?[i].endTime)),
          roomController: TextEditingController(text: sanitize(examRoutineModel?.data?[i].room)),
        ));
      }}

    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }

  String sanitize(String? value) {
    if (value == null || value.toLowerCase() == 'null') return '';
    return value;
  }



  bool isLoading = false;
  Future<void> storeExamRoutine(ExamRoutineBody body) async {
    isLoading = true;
    update();
    Response? response = await examRoutineRepository.storeExamRoutine(body);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }


}