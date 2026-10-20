import 'dart:developer';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/quiz_setting/domain/model/quiz_edit_model.dart';
import 'package:class_compass/feature/quiz_setting/domain/model/quiz_setting_model.dart';
import 'package:class_compass/feature/quiz_setting/domain/repository/quiz_setting_repository.dart';
import 'package:class_compass/feature/quiz_setting/presentation/widgets/exam_created_successfully_dialog.dart';

class QuizSettingController extends GetxController implements GetxService {
  final QuizSettingRepository quizSettingRepository;
  QuizSettingController({required this.quizSettingRepository});



  int? createdQuizId;
  Future<void> createQuizSetting(QuizSettingBody body) async {
    Response? response = await quizSettingRepository.createQuizSetting(body);
    if (response?.statusCode == 200) {
      createdQuizId = response?.body["data"]["id"];
      Get.dialog(ExamCreatedSuccessfullyDialog(courseId: body.courseId.toString(),));

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuizEditModel? quizEditModel;
  Future<void> updateQuizSetting(QuizSettingBody body, int id) async {
    Response? response = await quizSettingRepository.updateQuizSetting(body, id);
    log("bangla");
    if (response?.statusCode == 200) {
      createdQuizId = id;
      quizEditModel = QuizEditModel.fromJson(response?.body);
      Get.dialog(ExamCreatedSuccessfullyDialog(courseId: body.courseId.toString(),));

        await Get.find<QuestionController>().getQuestion(1, questionIds: quizEditModel?.data?.questionIds??[]).then((val){
          if(val.statusCode == 200){
            Get.find<QuestionController>().selectAllQuestionForQuizFromIds(quizEditModel?.data?.questionIds ?? []);
          }
        });

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> addQuestionToQuiz(List<int> questionIds, int id, String courseId) async {
    Response? response = await quizSettingRepository.addQuestionToQuiz(questionIds, id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("Question added successfully", isError: false);
      // Get.toNamed(RouteHelper.getCourseDetailsRoute(courseId));
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }




}
  