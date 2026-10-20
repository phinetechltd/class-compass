import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_body.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/repository/question_bank_board_repository.dart';

class QuestionBankBoardController extends GetxController implements GetxService {
  final QuestionBankBoardRepository questionBankBoardRepository;
  QuestionBankBoardController({required this.questionBankBoardRepository});

  ApiResponse<QuestionBankBoardItem>? questionBankBoardModel;
  Future<void> getQuestionBankBoard(int page) async {
    Response? response = await questionBankBoardRepository.getQuestionBankBoard(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<QuestionBankBoardItem>.fromJson(response?.body, (json)=> QuestionBankBoardItem.fromJson(json));
      if(page == 1){
        questionBankBoardModel = apiResponse;
      } else {
        questionBankBoardModel?.data?.data?.addAll(apiResponse.data!.data!);
        questionBankBoardModel?.data?.total = apiResponse.data!.total;
        questionBankBoardModel?.data?.currentPage = apiResponse.data!.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<int> selectedIds = [];
  void toggleSelected(int index){
    questionBankBoardModel?.data?.data?[index].isSelected = !(questionBankBoardModel?.data?.data?[index].isSelected ?? false);
    if(questionBankBoardModel?.data?.data?[index].isSelected == true){
      selectedIds.add(questionBankBoardModel?.data?.data?[index].id ?? 0);
    }else{
      selectedIds.remove(questionBankBoardModel?.data?.data?[index].id ?? 0);
    }
    Get.find<QuestionController>().questionFilter();
    update();
  }






  QuestionBankBoardItem? selectBoardItem;
  setSelectBoardItem(QuestionBankBoardItem item, {int? index}){
    selectBoardItem = item;
    if(index != null){
      Get.find<QuestionController>().questionYearBodyList[index].board?.add(Board(board: selectBoardItem?.shortName, desc: selectBoardItem?.board));
    }
    update();
  }

  bool isLoading = false;
  Future<void> createQuestionBankBoard(String board, String shortName) async {
    isLoading = true;
    update();
    Response? response = await questionBankBoardRepository.createQuestionBankBoard(board, shortName);
    if (response?.statusCode == 200) {
      isLoading = false;
      update();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestionBankBoard(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editQuestionBankBoard(String board, String shortName, int id) async {
    isLoading = true;
    update();
    Response? response = await questionBankBoardRepository.editQuestionBankBoard(board, shortName, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      update();
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getQuestionBankBoard(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestionBankBoard(int id) async {
    Response? response = await questionBankBoardRepository.deleteQuestionBankBoard(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestionBankBoard(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  