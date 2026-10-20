import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_body.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/domain/model/question_bank_year_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/domain/repository/question_bank_year_repository.dart';

class QuestionBankYearController extends GetxController implements GetxService {
  final QuestionBankYearRepository questionBankYearRepository;
  QuestionBankYearController({required this.questionBankYearRepository});


  ApiResponse<QuestionBankYearItem>? questionBankYearModel;
  Future<void> getQuestionBankYear(int page) async {
    Response? response = await questionBankYearRepository.getQuestionBankYear(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankYearItem>.fromJson(response!.body, (json)=> QuestionBankYearItem.fromJson(json));
      if(page == 1){
        questionBankYearModel = apiResponse;
      }else{
        questionBankYearModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankYearModel?.data?.total = apiResponse.data?.total;
        questionBankYearModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  QuestionBankYearItem? selectYearItem;
  void setSelectYearItem(QuestionBankYearItem item, {bool notify = true}){
    selectYearItem = item;
    Get.find<QuestionController>().addQuestionYearBody(QuestionYearBody(year: selectYearItem?.year, board: []));
    if(notify){
      update();
    }
  }



  bool isLoading = false;
  Future<void> createQuestionBankYear(String year) async {
    isLoading = true;
    update();
    Response? response = await questionBankYearRepository.createQuestionBankYear(year);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankYear(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankYear(String year, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankYearRepository.editQuestionBankYear(year, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankYear(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankYear(int id) async {
    Response? response = await questionBankYearRepository.deleteQuestionBankYear(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankYear(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  