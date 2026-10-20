import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/repository/question_bank_group_repository.dart';

class QuestionBankGroupController extends GetxController implements GetxService {
  final QuestionBankGroupRepository questionBankGroupRepository;
  QuestionBankGroupController({required this.questionBankGroupRepository});


  QuestionBankGroupModel? questionBankGroupModel;
  Future<void> getQuestionBankGroup(int page) async {
    Response? response = await questionBankGroupRepository.getQuestionBankGroup(page);
    if (response?.statusCode == 200) {
      if(page ==1){
        questionBankGroupModel = QuestionBankGroupModel.fromJson(response?.body);
      } else {
        questionBankGroupModel?.data?.data?.addAll(QuestionBankGroupModel.fromJson(response?.body).data!.data!);
        questionBankGroupModel?.data?.currentPage = QuestionBankGroupModel.fromJson(response?.body).data?.currentPage;
        questionBankGroupModel?.data?.total = QuestionBankGroupModel.fromJson(response?.body).data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuestionBankGroupItem? selectedGroupItem;
  void setSelectGroupItem(QuestionBankGroupItem item, {bool notify = true}){
    selectedGroupItem = item;
    if(notify) {
      update();
    }
  }



  bool isLoading = false;
  Future<void> createQuestionBankGroup(String classId, String name) async {
    isLoading = true;
    update();
    Response? response = await questionBankGroupRepository.createQuestionBankGroup(classId, name);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankGroup(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankGroup(String classId, String name, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankGroupRepository.editQuestionBankGroup(classId, name, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankGroup(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankGroup(int id) async {
    Response? response = await questionBankGroupRepository.deleteQuestionBankGroup(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankGroup(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  