import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/repository/question_bank_level_repository.dart';

class QuestionBankLevelController extends GetxController implements GetxService {
  final QuestionBankLevelRepository questionBankLevelRepository;
  QuestionBankLevelController({required this.questionBankLevelRepository});

  QuestionBankLevelModel? questionBankLevelModel;
  Future<void> getQuestionBankLevel(int page) async {
    Response? response = await questionBankLevelRepository.getQuestionBankLevel(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionBankLevelModel = QuestionBankLevelModel.fromJson(response?.body);
      } else {
        questionBankLevelModel?.data?.data?.addAll(QuestionBankLevelModel.fromJson(response?.body).data!.data!);
        questionBankLevelModel?.data?.total = QuestionBankLevelModel.fromJson(response?.body).data!.total;
        questionBankLevelModel?.data?.currentPage = QuestionBankLevelModel.fromJson(response?.body).data!.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankLevelModel?.data?.data?[index].isSelected = !(questionBankLevelModel?.data?.data?[index].isSelected ?? false);
    if(questionBankLevelModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankLevelModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankLevelModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }

  QuestionBankLevelItem? selectedLevelItem;
  void setSelectLevelItem(QuestionBankLevelItem item, {bool notify = true}){
    selectedLevelItem = item;
    if(notify){
      update();
    }
  }

  bool isLoading = false;
  Future<Response> createQuestionBankLevel(String name, int chapterId) async {
    isLoading = true;
    update();
    Response? response = await questionBankLevelRepository.createQuestionBankLevel(name, chapterId);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankLevel(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestionBankLevel(String name, int chapterId, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankLevelRepository.editQuestionBankLevel(name, chapterId, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankLevel(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankLevel(int id) async {
    Response? response = await questionBankLevelRepository.deleteQuestionBankLevel(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankLevel(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  