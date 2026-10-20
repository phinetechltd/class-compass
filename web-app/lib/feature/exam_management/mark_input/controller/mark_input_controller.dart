
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/models/mark_input_body.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/repository/mark_input_repository.dart';

class MarkInputController extends GetxController implements GetxService{
  final MarkInputRepository markInputRepository;
  MarkInputController({required this.markInputRepository});

  bool isLoading = false;
  final Map<String, TextEditingController> markControllers = {};
  MarkInputModel? markInputModel;
  Future<void> markInputGet(int classId, int examId, int groupId, int subjectId) async {
    isLoading = true;
    update();
    Response? response = await markInputRepository.getMarkInput(classId, examId, groupId, subjectId);
    if(response?.statusCode == 200){
      isLoading = false;
      markInputModel = MarkInputModel.fromJson(response?.body);
      _initializeControllers();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> markInput(MarkInputBody body) async {
    isLoading = true;
    update();
    Response? response = await markInputRepository.markInput(body);
    if(response?.statusCode == 200){
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }




  List<String> getDynamicHeadings(MarkInputModel? markInputModel) {
    List<String> headings = ["roll", "name"];
    if (markInputModel?.data?.markConfig?.isNotEmpty == true) {
      for (var subject in markInputModel!.data!.markConfig!) {
        headings.add(subject.markConfigExamCode?.title ?? "Subject");
      }
    }
    update();
    return headings;
  }

  void _initializeControllers() {
    markControllers.clear();
    if (markInputModel?.data?.students != null && markInputModel?.data?.markConfig != null) {
      for (var student in markInputModel!.data!.students!) {
        for (var markConfig in markInputModel!.data!.markConfig!) {
          final key = '${student.id}_${markConfig.markConfigExamCode?.id}';
          markControllers[key] = TextEditingController(
            text: markConfig.markConfigExamCode?.passMark ?? '',
          );
        }
      }
    }
  }

  @override
  void onClose() {
    markControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
  TextEditingController getController(int studentId, int examCodeId) {
    final key = '${studentId}_$examCodeId';
    return markControllers[key] ?? TextEditingController();
  }

}