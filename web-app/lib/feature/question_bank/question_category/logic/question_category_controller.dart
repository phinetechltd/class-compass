import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/repository/question_category_repository.dart';

class QuestionCategoryController extends GetxController implements GetxService {
  final QuestionCategoryRepository questionCategoryRepository;
  QuestionCategoryController({required this.questionCategoryRepository});


  bool isLoading = false;
  QuestionCategoryModel? questionCategoryModel;
  Future<void> getQuestionCategory(int page) async {
    Response? response = await questionCategoryRepository.getQuestionCategory(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionCategoryModel = QuestionCategoryModel.fromJson(response?.body);
      }else{
        questionCategoryModel?.data?.data?.addAll(QuestionCategoryModel.fromJson(response?.body).data?.data??[]);
        questionCategoryModel?.data?.total = QuestionCategoryModel.fromJson(response?.body).data?.total;
        questionCategoryModel?.data?.currentPage = QuestionCategoryModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuestionCategoryItem? selectedQuestionCategoryItem;
  void setSelectQuestionCategoryItem(QuestionCategoryItem item, {bool notify = true}){
    selectedQuestionCategoryItem = item;
    if(notify) {
      update();
    }
  }

  Future<void> createQuestionCategory(String name, String priority) async {
    isLoading = true;
    update();
    Response? response = await questionCategoryRepository.createQuestionCategory(name, priority);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionCategory(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionCategory(String name, String priority, int id) async {
    isLoading = true;
    update();
    Response? response = await questionCategoryRepository.editQuestionCategory(name, priority, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionCategory(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionCategory(int id) async {
    Response? response = await questionCategoryRepository.deleteQuestionCategory(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionCategory(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  