import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/model/question_bank_tag_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/repository/question_bank_tag_repository.dart';

class QuestionBankTagController extends GetxController implements GetxService {
  final QuestionBankTagRepository questionBankTagRepository;
  QuestionBankTagController({required this.questionBankTagRepository});


  ApiResponse<QuestionBankTagItem>? questionBankTagModel;
  Future<void> getQuestionBankTag(int page) async {
    Response? response = await questionBankTagRepository.getQuestionBankTag(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankTagItem>.fromJson(response!.body,(json)=> QuestionBankTagItem.fromJson(json));

      if(page == 1){
        questionBankTagModel = apiResponse;
      }else{
        questionBankTagModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankTagModel?.data?.total = apiResponse.data?.total;
        questionBankTagModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankTagModel?.data?.data?[index].isSelected = !(questionBankTagModel?.data?.data?[index].isSelected ?? false);
    if(questionBankTagModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankTagModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankTagModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }


  QuestionBankTagItem? selectTagItem;
  void setSelectTagItem(QuestionBankTagItem item){
    selectTagItem = item;
    update();
  }



  bool isLoading = false;
  Future<void> createQuestionBankTag(String year) async {
    isLoading = true;
    update();
    Response? response = await questionBankTagRepository.createQuestionBankTag(year);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankTag(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankTag(String year, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankTagRepository.editQuestionBankTag(year, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankTag(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankTag(int id) async {
    Response? response = await questionBankTagRepository.deleteQuestionBankTag(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankTag(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  