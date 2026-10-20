
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/option_item_body.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_body.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/domain/repository/question_repository.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/helper/route_helper.dart';

class QuestionController extends GetxController implements GetxService {
  final QuestionRepository questionRepository;
  QuestionController({required this.questionRepository});


  bool isLoading = false;
  QuestionModel? questionModel;
  Future<Response> getQuestion(int page ,{String? search,int? categoryId, int? classId, int? groupId, int? subjectId, int? chapterId, int? topicId, String? type, List<int>? types, List<int>? levels, List<int>? topics, List<int>? tags,  List<int>? sources, List<int>? subSources, List<int>? questionIds}) async {
    if(page == 1 && questionModel != null){
      questionModel = null;
      update();
    }
    Response? response = await questionRepository.getQuestion(page, search: search, categoryId: categoryId, classId: classId, groupId: groupId, subjectId: subjectId, chapterId: chapterId, topicId: topicId, type: type, types: types, levels: levels, topics: topics, tags: tags, sources: sources, subSources: subSources, questionIds: questionIds);
    if (response?.statusCode == 200) {
      if(page == 1){
        questionModel = QuestionModel.fromJson(response?.body);
      }else{
        questionModel?.data?.data?.addAll(QuestionModel.fromJson(response?.body).data?.data??[]);
        questionModel?.data?.total = QuestionModel.fromJson(response?.body).data?.total;
        questionModel?.data?.currentPage = QuestionModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  List<int> selectedQuestionIds = [];
  void selectUnselectQuestionForQuiz(int index) {
    if (questionModel?.data?.data?[index].selectForQuiz == true) {
      selectedQuestionIds.remove(questionModel?.data?.data?[index].id);
    } else {
      selectedQuestionIds.add(questionModel?.data?.data?[index].id ?? 0);
    }
    questionModel?.data?.data?[index].selectForQuiz = !(questionModel?.data?.data?[index].selectForQuiz ?? false);

    update();
  }

  selectAllQuestionForQuizFromIds(List<int> ids) {
    selectedQuestionIds.clear();
    if(questionModel?.data?.data != null) {
      for (var question in questionModel!.data!.data!) {
        if(ids.contains(question.id)) {
          question.selectForQuiz = true;
          selectedQuestionIds.add(question.id!);
        } else {
          question.selectForQuiz = false;
        }
      }
    }
    update();
  }


  void removeAllSelectedQuestionIds({bool notify = true}) {
    selectedQuestionIds.clear();
    if(questionModel?.data?.data != null) {
      for (var question in questionModel!.data!.data!) {
        question.selectForQuiz = false;
      }
    }
    if(notify) {
      update();
    }
  }


  Future<void> questionFilter({String? search, int? offset}) async{
    getQuestion(offset??1, search: search, subjectId: Get.find<QuestionBankSubjectController>().selectSubjectItem?.id,
      type: typeSelectedForFilter,
      chapterId: Get.find<QuestionBankChapterController>().selectChapterItem?.id,
      topicId: Get.find<QuestionBankTopicsController>().selectQuestionBankTopicItem?.id,
      types: Get.find<QuestionBankTypesController>().selectedIds,
      levels: Get.find<QuestionBankLevelController>().selectedIds,
      tags: Get.find<QuestionBankLevelController>().selectedIds,
      sources: Get.find<QuestionBankLevelController>().selectedIds,
      subSources: Get.find<QuestionBankLevelController>().selectedIds,

    );
  }

  void toggleQuestionItemSelection(int index) {
    questionModel?.data?.data?[index].isSelected = !(questionModel?.data?.data?[index].isSelected ?? false);

    update();
  }


  List<String> questionType = ['multiple_choice', 'true_false', 'multiple_true_false'];
  String? selectedQuestionType = "multiple_choice";
  void changeQuestionType(String? value, {bool notify = true}){
    selectedQuestionType = value;
    if(notify) {
      update();
    }
  }

  String? typeSelectedForFilter;
  void changeTypeForFilter(String? value, {bool notify = true}){
    typeSelectedForFilter = value;
    questionFilter();
    if(notify) {
      update();
    }
  }


  List<OptionItemBody> options = [];

  void addOption({bool notify = true}) {
    options.add(OptionItemBody(controller: TextEditingController()));
    if(notify) {
    update();
    }

  }


  void updateOption(QuestionItem? questionItem) {
    if (questionItem == null || questionItem.options == null) return;
    options.clear();
    final optionList = questionItem.options!;
    final correctAnswers = questionItem.correctAnswer ?? [];
    final type = questionItem.type;
    for (int i = 0; i < optionList.length; i++) {
      final option = optionList[i];
      bool isSelected = false;
      if (type == "multiple_choice") {
        isSelected = correctAnswers.contains(option);
      } else {
        if (i < correctAnswers.length) {
          isSelected = correctAnswers[i].toString().trim().toLowerCase() == 'true';
        }
      }

      options.add(
        OptionItemBody(
          isSelected: isSelected,
          controller: TextEditingController(text: option),
        ),
      );
    }
  }




  void deleteOption(int index) {
    options[index].controller.dispose();
    options.removeAt(index);
    update();
  }

  void selectOption(int index) {
    options[index].isSelected = !options[index].isSelected ;
      update();
  }

  void clearAllOption(){
    options.clear();
    addOption(notify: false);
  }

  List<QuestionYearBody> questionYearBodyList = [];
  void addQuestionYearBody(QuestionYearBody questionYearBody, {bool notify = true}) {
    questionYearBodyList.add(questionYearBody);
    if(notify) {
      update();
    }
  }
  void clearQuestionYearBody() {
    questionYearBodyList.clear();
  }
  void removeQuestionYearBody(QuestionYearBody questionYearBody) {
    questionYearBodyList.remove(questionYearBody);
    update();
  }


  void updateQuestionYearBody(List<QuestionYearBody> questionYearBodyList) {
    this.questionYearBodyList = questionYearBodyList;
  }



  Future<Response> createQuestion(QuestionBody body) async {
    isLoading = true;
    update();
    Response? response = await questionRepository.createQuestion(body);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.toNamed(RouteHelper.getQuestionRoute("question"));
      showCustomSnackBar("added_successfully".tr, isError: false);
      getQuestion(1);
      Get.find<QuestionController>().removeAllSelectedQuestionIds(notify: false);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> editQuestion(QuestionBody body,int id) async {
    isLoading = true;
    update();
    Response? response = await questionRepository.editQuestion(body, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      questionFilter();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteQuestion(int id) async {
    Response? response = await questionRepository.deleteQuestion(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getQuestion(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  final _outerScrollEnabled = true.obs;

  bool get outerScrollEnabled => _outerScrollEnabled.value;

  void disableOuterScroll() => _outerScrollEnabled.value = false;
  void enableOuterScroll() => _outerScrollEnabled.value = true;

  void reorderOption(int oldIndex, int newIndex) {
    final item = options.removeAt(oldIndex);
    options.insert(newIndex, item);
    update();
  }

  int questionPaperColumn = 2;
  void changeQuestionPaperColumn(int value){
    questionPaperColumn = value;
    update();
  }

  TextEditingController schoolNameController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController examNameController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController markController = TextEditingController();
  TextEditingController timeController = TextEditingController();

}
  