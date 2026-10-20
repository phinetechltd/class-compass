import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/repository/question_bank_class_repository.dart';

class QuestionBankClassController extends GetxController implements GetxService {
  final QuestionBankClassRepository questionBankClassRepository;
  QuestionBankClassController({required this.questionBankClassRepository});



  ApiResponse<QuestionBankClassItem>? questionBankClassModel;
  Future<void> getQuestionBankClass(int page) async {
    Response? response = await questionBankClassRepository.getQuestionBankClass(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankClassItem>.fromJson(response?.body, (json) => QuestionBankClassItem.fromJson(json));
      if(page == 1) {
        questionBankClassModel = apiResponse;
      }
      else {
        questionBankClassModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankClassModel?.data?.currentPage = apiResponse.data?.currentPage;
        questionBankClassModel?.data?.total = apiResponse.data?.total;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  QuestionBankClassItem? selectedClassItem;
  void setSelectClass(QuestionBankClassItem item, {bool notify = true}) {
    selectedClassItem = item;
    if(notify) {
      update();
    }
  }



  bool isLoading = false;
  Future<void> createQuestionBankClass(String name) async {
    isLoading = true;
    update();
    Response? response = await questionBankClassRepository.createQuestionBankClass(name);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankClass(String name, int id) async {
    Response? response = await questionBankClassRepository.editQuestionBankClass(id, name);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankClass(int id) async {
    Response? response = await questionBankClassRepository.deleteQuestionBankClass(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankClass(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  