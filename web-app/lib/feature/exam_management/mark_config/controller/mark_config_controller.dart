import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_model.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_store_body.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/grand_final_exam_percentage_model.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/grand_final_exam_percentage_store_body.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/repository/mark_config_repository.dart';

class MarkConfigController extends GetxController implements GetxService{
  final MarkConfigRepository markConfigRepository;
  MarkConfigController({required this.markConfigRepository});

  GeneralExamModel? generalExamModel;
  List<ExamCodeBody>? examCodeBodyList;

  bool isLoading = false;

  Future<void> getGeneralExamList(int classId, int groupId) async {
    isLoading = true;
    update();
    Response? response = await markConfigRepository.getGeneralExamList(classId, groupId);
    if(response?.statusCode == 200){
      generalExamModel = GeneralExamModel.fromJson(response?.body);
      if (generalExamModel != null &&
          generalExamModel?.data?.examCodes != null &&
          generalExamModel!.data!.examCodes!.isNotEmpty) {
        examCodeBodyList = [];
        for (var exam in generalExamModel!.data!.examCodes!) {
          examCodeBodyList?.add(ExamCodeBody(
            title: TextEditingController(text: exam.shortCodeTitle ?? ''),
            totalMarks: TextEditingController(text: exam.totalMark?.toString() ?? ''),
            passMark: TextEditingController(text: exam.passMark?.toString() ?? ''),
            acceptance: TextEditingController(text: exam.acceptPercent?.toString() ?? ''),
          ));
        }
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }


  GeneralExamModel? markViewModel;
  Future<void> getMarkViewReport(int classId, int groupId, int examId) async {
    isLoading = true;
    update();
    Response? response = await markConfigRepository.markConfigView(classId, groupId, examId);
    if(response?.statusCode == 200){
      markViewModel = GeneralExamModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }

  GrandFinalMarkUpdateModel? grandFinalMarkUpdateModel;
  List<GrandFinalExamPercentageBody>? grandFinalExamPercentageBodyList;
  Future<Response?> getGrandFinalExamPercentage(int classId) async {
    setSelectedClassId(classId);
    Response? response = await markConfigRepository.getGrandFinalPercentage(classId);
    if(response?.statusCode == 200){
      grandFinalMarkUpdateModel = GrandFinalMarkUpdateModel.fromJson(response?.body);
      grandFinalExamPercentageBodyList = [];
     if (grandFinalMarkUpdateModel != null &&
        grandFinalMarkUpdateModel?.data?.data != null &&
        grandFinalMarkUpdateModel!.data!.data!.isNotEmpty) {
       for (var exam in grandFinalMarkUpdateModel!.data!.data!) {
         grandFinalExamPercentageBodyList?.add(GrandFinalExamPercentageBody(
           examId: exam.examId!,
           name: exam.examName!,
           percentage: TextEditingController(text: exam.percentage?.toString() ?? ''),
           serialNo: TextEditingController(text: exam.serialNo?.toString() ?? ''),
         ));
       }
     }
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
    return response;
  }

  Future<void> storeGrandFinalExamPercentage(GrandFinalExamPercentageStoreBody body) async {
    isLoading = true;
    update();
    Response? response = await markConfigRepository.storeGrandFinalExamPercentage(body);
    if(response?.statusCode == 200){
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }




  void removeExamCode(int index){
    examCodeBodyList?.removeAt(index);
    update();
  }





  Future<void> storeGeneralExam(GeneralExamStoreBody body) async {
    Response? response = await markConfigRepository.storeGeneralExam(body);
    if(response?.statusCode == 200){
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }
    update();
  }




  int markConfigTypeIndex = 0;
  void setMarkConfigTypeIndex(int typeIndex){
    markConfigTypeIndex = typeIndex;
    update();
  }

  bool selectedAllSubject = false;
  void toggleAllSubject(){
    selectedAllSubject = !selectedAllSubject;
    generalExamModel?.data?.subjects?.forEach((element) {
      element.isSelected = selectedAllSubject;
    });
    update();
  }

  void toggleSubject(int index){
    generalExamModel?.data?.subjects?[index].isSelected = !generalExamModel!.data!.subjects![index].isSelected!;
    selectedAllSubject = generalExamModel?.data?.subjects?.every((element) => element.isSelected == true) ?? false;
    update();
  }


  bool selectedAllExam = false;
  void toggleAllExam() {
    selectedAllExam = !selectedAllExam;
    generalExamModel?.data?.classExams?.forEach((element) {
      element.selected = selectedAllExam;
    });
    update();

  }
  void toggleExam(int index) {
    generalExamModel?.data?.classExams?[index].selected = !generalExamModel!.data!.classExams![index].selected!;
    selectedAllExam = generalExamModel?.data?.classExams?.every((element) => element.selected == true) ?? false;
    update();
  }

  int? selectedClassId;
  void setSelectedClassId(int classId){
    selectedClassId = classId;
    update();
  }



}