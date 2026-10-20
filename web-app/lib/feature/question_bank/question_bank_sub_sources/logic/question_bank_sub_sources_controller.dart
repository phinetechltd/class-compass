import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/repository/question_bank_sub_sources_repository.dart';

class QuestionBankSubSourcesController extends GetxController implements GetxService {
  final QuestionBankSubSourcesRepository questionBankSubSourcesRepository;
  QuestionBankSubSourcesController({required this.questionBankSubSourcesRepository});


  QuestionBankSubSourceModel? questionBankSubSourceModel;
  Future<void> getQuestionBankSubSources(int page) async {
    Response? response = await questionBankSubSourcesRepository.getQuestionBankSubSources(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionBankSubSourceModel = QuestionBankSubSourceModel.fromJson(response?.body);
      } else {
        questionBankSubSourceModel?.data?.data?.addAll(QuestionBankSubSourceModel.fromJson(response?.body).data!.data!);
        questionBankSubSourceModel?.data?.total = QuestionBankSubSourceModel.fromJson(response?.body).data?.total;
        questionBankSubSourceModel?.data?.currentPage = QuestionBankSubSourceModel.fromJson(response?.body).data?.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankSubSourceModel?.data?.data?[index].isSelected = !(questionBankSubSourceModel?.data?.data?[index].isSelected ?? false);
    if(questionBankSubSourceModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankSubSourceModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankSubSourceModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }

  QuestionBankSubSourceItem? selectedQuestionBankSubSourcesItem;
  void setQuestionBankSubSourcesItem(QuestionBankSubSourceItem item, {bool notify = true}) {
    selectedQuestionBankSubSourcesItem = item;
    if (notify) {
      update();
    }
  }

  bool isLoading = false;

  Future<Response> createQuestionBankSubSources(String subSource, int sourceId) async {
    isLoading = true;
    update();
    Response? response = await questionBankSubSourcesRepository.createQuestionBankSubSources(subSource, sourceId);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankSubSources(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankSubSources(String subSource, int sourceId, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankSubSourcesRepository.editQuestionBankSubSources(subSource, sourceId, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankSubSources(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankSubSources(int id) async {
    Response? response = await questionBankSubSourcesRepository.deleteQuestionBankSubSources(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankSubSources(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  