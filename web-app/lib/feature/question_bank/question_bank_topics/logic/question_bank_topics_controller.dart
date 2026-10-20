import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/domain/model/question_bank_topics_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/domain/repository/question_bank_topics_repository.dart';

class QuestionBankTopicsController extends GetxController implements GetxService {
  final QuestionBankTopicsRepository questionBankTopicsRepository;
  QuestionBankTopicsController({required this.questionBankTopicsRepository});

  ApiResponse<QuestionBankTopicsItem>? questionBankTopicsModel;
  Future<void> getQuestionBankTopics(int page, {int? chapterId}) async {
    Response? response = await questionBankTopicsRepository.getQuestionBankTopics(page, chapterId : chapterId);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankTopicsItem>.fromJson(response?.body,(json)=> QuestionBankTopicsItem.fromJson(json));
      if(page == 1){
        questionBankTopicsModel = apiResponse;
      }
      else {
        questionBankTopicsModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankTopicsModel?.data?.total = apiResponse.data!.total;
        questionBankTopicsModel?.data?.currentPage = apiResponse.data!.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  QuestionBankTopicsItem? selectQuestionBankTopicItem;
  void setSelectQuestionBankTopicItem(QuestionBankTopicsItem? val, {bool notify = true, bool filter = false}){
    selectQuestionBankTopicItem = val;
    if(filter){
      Get.find<QuestionController>().questionFilter();
    }
    if(notify){
    update();
    }
  }


  bool isLoading = false;
  Future<Response> createQuestionBankTopics(String name, int chapterId) async {
    isLoading = true;
    update();
    Response? response = await questionBankTopicsRepository.createQuestionBankTopics(name, chapterId);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankTopics(1);

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankTopics(String name, int chapterId, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankTopicsRepository.editQuestionBankTopics(name, chapterId, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankTopics(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankTopics(int id) async {
    Response? response = await questionBankTopicsRepository.deleteQuestionBankTopics(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankTopics(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  