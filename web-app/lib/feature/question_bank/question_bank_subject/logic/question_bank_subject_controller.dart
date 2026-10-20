import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_body.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/repository/question_bank_subject_repository.dart';

class QuestionBankSubjectController extends GetxController implements GetxService {
  final QuestionBankSubjectRepository questionBankSubjectRepository;
  QuestionBankSubjectController({required this.questionBankSubjectRepository});


  ApiResponse<QuestionBankSubjectItem>? questionBankSubjectModel;
  Future<void> getQuestionBankSubject(int page) async {
    Response? response = await questionBankSubjectRepository.getQuestionBankSubject(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankSubjectItem>.fromJson(response?.body, (json)=> QuestionBankSubjectItem.fromJson(json));
      if(page == 1){
        questionBankSubjectModel = apiResponse;
      } else {
        questionBankSubjectModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankSubjectModel?.data?.total = apiResponse.data!.total;
        questionBankSubjectModel?.data?.currentPage = apiResponse.data!.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuestionBankSubjectItem? selectSubjectItem;
  void setSelectSubjectItem(QuestionBankSubjectItem item, {bool notify = true, bool filter = false}) {
    selectSubjectItem = item;
      Get.find<QuestionBankChapterController>().getQuestionBankChapter(1, subjectId: item.id);
    if(filter){
      Get.find<QuestionController>().questionFilter();
    }
    if(notify) {
      update();
    }
  }

  bool isLoading = false;
  Future<Response> createQuestionBankSubject(QuestionBankSubjectBody body) async {
    isLoading = true;
    update();
    Response? response = await questionBankSubjectRepository.createQuestionBankSubject(body);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankSubject(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankSubject(QuestionBankSubjectBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankSubjectRepository.editQuestionBankSubject(body, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankSubject(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankSubject(int id) async {
    Response? response = await questionBankSubjectRepository.deleteQuestionBankSubject(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankSubject(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  