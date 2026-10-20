import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/model/question_bank_chapter_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/repository/question_bank_chapter_repository.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';

class QuestionBankChapterController extends GetxController implements GetxService {
  final QuestionBankChapterRepository questionBankChapterRepository;
  QuestionBankChapterController({required this.questionBankChapterRepository});


  QuestionBankChapterModel? questionBankChapterModel;
  Future<void> getQuestionBankChapter(int page, {int? subjectId}) async {
    Response? response = await questionBankChapterRepository.getQuestionBankChapter(page, subjectId: subjectId);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionBankChapterModel = QuestionBankChapterModel.fromJson(response?.body);
      } else {
        questionBankChapterModel?.data?.data?.addAll(QuestionBankChapterModel.fromJson(response?.body).data!.data!);
        questionBankChapterModel?.data?.total = QuestionBankChapterModel.fromJson(response?.body).data!.total;
        questionBankChapterModel?.data?.currentPage = QuestionBankChapterModel.fromJson(response?.body).data!.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  QuestionBankChapterItem? selectChapterItem;
  void setSelectChapterItem(QuestionBankChapterItem item, {bool notify = true, bool filter = false}) {
    selectChapterItem = item;
    Get.find<QuestionBankTopicsController>().getQuestionBankTopics(1, chapterId: item.id);

    if(filter){
      Get.find<QuestionController>().questionFilter();
    }
    if (notify) {
      update();
    }
  }

  bool isLoading = false;
  Future<Response> createQuestionBankChapter(String name, int subjectId) async {
    isLoading = true;
    update();
    Response? response = await questionBankChapterRepository.createQuestionBankChapter(name, subjectId);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankChapter(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankChapter(String name, int subjectId, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankChapterRepository.editQuestionBankChapter(name, subjectId, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankChapter(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankChapter(int id) async {
    Response? response = await questionBankChapterRepository.deleteQuestionBankChapter(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankChapter(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  