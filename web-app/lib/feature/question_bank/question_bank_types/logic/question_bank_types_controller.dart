import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/repository/question_bank_types_repository.dart';

class QuestionBankTypesController extends GetxController implements GetxService {
  final QuestionBankTypesRepository questionBankTypesRepository;
  QuestionBankTypesController({required this.questionBankTypesRepository});

  QuestionBankTypesModel? questionBankTypesModel;
  Future<void> getQuestionBankTypes(int page) async {
    Response? response = await questionBankTypesRepository.getQuestionBankTypes(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionBankTypesModel = QuestionBankTypesModel.fromJson(response?.body);
      } else {
        questionBankTypesModel?.data?.data?.addAll(QuestionBankTypesModel.fromJson(response?.body).data!.data!);
        questionBankTypesModel?.data?.total = QuestionBankTypesModel.fromJson(response?.body).data!.total;
        questionBankTypesModel?.data?.currentPage = QuestionBankTypesModel.fromJson(response?.body).data!.currentPage;
      }
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankTypesModel?.data?.data?[index].isSelected = !(questionBankTypesModel?.data?.data?[index].isSelected ?? false);
    if(questionBankTypesModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankTypesModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankTypesModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }






  QuestionBankTypesItem? selectTypeItem;
  void setSelectTypeItem(QuestionBankTypesItem item, {bool notify = true}) {
    selectTypeItem = item;
    if (notify) {
      update();
    }
  }

  bool toggleOn = false;
  void typeFilterToggle() {
    toggleOn = !toggleOn;
    update();
  }

  bool isLoading = false;

  Future<void> createQuestionBankTypes(String typeName) async {
    isLoading = true;
    update();
    Response? response = await questionBankTypesRepository.createQuestionBankTypes(typeName);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankTypes(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankTypes(String typeName, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankTypesRepository.editQuestionBankTypes(typeName, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankTypes(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankTypes(int id) async {
    Response? response = await questionBankTypesRepository.deleteQuestionBankTypes(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankTypes(1);
      
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  