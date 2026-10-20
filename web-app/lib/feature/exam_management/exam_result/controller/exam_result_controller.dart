
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam_result/domain/models/exam_result_model.dart';
import 'package:class_compass/feature/exam_management/exam_result/domain/repository/exam_result_repository.dart';

class ExamResultController extends GetxController implements GetxService{
  final ExamResultRepository examResultRepository;
  ExamResultController({required this.examResultRepository});

  bool isLoading = false;
  ExamResultModel? examResultModel;
  Future<void> getExamResult(int page) async {
    isLoading = true;
    update();
    Response? response = await examResultRepository.getExamResult(
        Get.find<ClassController>().selectedClassItem!.id!,
        Get.find<GroupController>().groupItem?.id,
        Get.find<ExamController>().selectedExamItem!.id, page);
    if(response?.statusCode == 200){
      isLoading = false;
      examResultModel = ExamResultModel.fromJson(response?.body);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}