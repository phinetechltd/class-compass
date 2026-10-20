import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/repository/question_bank_sources_repository.dart';

class QuestionBankSourcesController extends GetxController implements GetxService {
  final QuestionBankSourcesRepository questionBankSourcesRepository;
  QuestionBankSourcesController({required this.questionBankSourcesRepository});


  bool isLoading = false;
  ApiResponse<QuestionBankSourcesItem>? questionBankSourcesModel;
  Future<void> getQuestionBankSources(int page) async {
    Response? response = await questionBankSourcesRepository.getQuestionBankSources(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankSourcesItem>.fromJson(response?.body, (json) => QuestionBankSourcesItem.fromJson(json));
      if(page == 1){
        questionBankSourcesModel = apiResponse;
      } else {
        questionBankSourcesModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankSourcesModel?.data?.total = apiResponse.data?.total;
        questionBankSourcesModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankSourcesModel?.data?.data?[index].isSelected = !(questionBankSourcesModel?.data?.data?[index].isSelected ?? false);
    if(questionBankSourcesModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankSourcesModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankSourcesModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }


  QuestionBankSourcesItem? selectedQuestionBankSourcesItem;
  void setQuestionBankSourcesItem(QuestionBankSourcesItem item, {bool notify = true}) {
    selectedQuestionBankSourcesItem = item;
    if (notify) {
      update();
    }

  }


  Future<Response> createQuestionBankSources(String courseName) async {
    isLoading = true;
    update();
    Response? response = await questionBankSourcesRepository.createQuestionBankSources(courseName);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankSources(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankSources(String sourceName, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankSourcesRepository.editQuestionBankSources(sourceName, id);
    if (response?.statusCode == 200) {
      Get.back();
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankSources(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankSources(int id) async {
    Response? response = await questionBankSourcesRepository.deleteQuestionBankSources(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankSources(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  