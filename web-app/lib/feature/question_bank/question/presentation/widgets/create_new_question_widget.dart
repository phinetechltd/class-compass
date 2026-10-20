

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/custom_rich_editor.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_body.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/option_management_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_year_selection_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/select_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/select_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/select_question_bank_group_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/select_question_bank_level_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/select_question_bank_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/select_question_bank_sub_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/select_question_bank_subject_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/widgets/select_question_bank_year_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/select_question_bank_topic_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/select_question_bank_types_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/logic/question_bank_year_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/logic/question_category_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/select_question_category_widget.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:responsive_grid/responsive_grid.dart';



class CreateNewQuestionWidget extends StatefulWidget {
  final QuestionItem? questionItem;
  final VoidCallback? onEditorPointerDown;
  final VoidCallback? onEditorPointerUp;
  const CreateNewQuestionWidget({super.key, this.questionItem, this.onEditorPointerDown, this.onEditorPointerUp});

  @override
  State<CreateNewQuestionWidget> createState() => _CreateNewQuestionWidgetState();
}

class _CreateNewQuestionWidgetState extends State<CreateNewQuestionWidget> {
   HtmlEditorController questionTextController = HtmlEditorController();
   HtmlEditorController explanationController = HtmlEditorController();


  @override
  void initState() {
    Get.find<QuestionController>().clearQuestionYearBody();
    Get.find<QuestionController>().clearAllOption();
    super.initState();
    if (widget.questionItem != null) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 2000), () async {
          questionTextController.setText(widget.questionItem!.question??'');
          explanationController.setText(widget.questionItem?.explanation??'');

        });
      });

      Get.find<QuestionController>().changeQuestionType(widget.questionItem?.type, notify: false);
      if(widget.questionItem?.classItem != null) {
        Get.find<QuestionBankClassController>().setSelectClass(widget.questionItem!.classItem!, notify: false);
      }
      if(widget.questionItem?.group != null) {
        Get.find<QuestionBankGroupController>().setSelectGroupItem(widget.questionItem!.group!, notify: false);
      }
      if(widget.questionItem?.subject != null) {
        Get.find<QuestionBankSubjectController>().setSelectSubjectItem(widget.questionItem!.subject!, notify: false);
      }
      if(widget.questionItem?.chapter != null) {
        Get.find<QuestionBankChapterController>().setSelectChapterItem(widget.questionItem!.chapter!, notify: false);
      }

      if(widget.questionItem?.questionCategory != null) {
        Get.find<QuestionCategoryController>().setSelectQuestionCategoryItem(widget.questionItem!.questionCategory!, notify: false);
      }
      if(widget.questionItem?.levels != null && widget.questionItem!.levels!.isNotEmpty) {
        Get.find<QuestionBankLevelController>().setSelectLevelItem(widget.questionItem!.levels![0], notify: false);
      }

      if(widget.questionItem?.topics != null && widget.questionItem!.topics!.isNotEmpty) {
        Get.find<QuestionBankTopicsController>().setSelectQuestionBankTopicItem(widget.questionItem!.topics![0], notify: false);
      }

      if(widget.questionItem?.types != null && widget.questionItem!.types!.isNotEmpty) {
        Get.find<QuestionBankTypesController>().setSelectTypeItem(widget.questionItem!.types![0], notify: false);
      }
      if(widget.questionItem?.sources != null && widget.questionItem!.sources!.isNotEmpty) {
        Get.find<QuestionBankSourcesController>().setQuestionBankSourcesItem(widget.questionItem!.sources![0], notify: false);
      }
      if(widget.questionItem?.subSources != null && widget.questionItem!.subSources!.isNotEmpty) {
        Get.find<QuestionBankSubSourcesController>().setQuestionBankSubSourcesItem(widget.questionItem!.subSources![0], notify: false);
      }
      if (widget.questionItem?.questionYear != null && widget.questionItem!.questionYear!.isNotEmpty) {

        List<dynamic> rawList = widget.questionItem!.questionYear!;

        Map<String, List<Board>> grouped = {};

        for (var item in rawList) {
          String year = item.year ?? "";
          Board board = Board(board: item.board, desc: item.desc);
          grouped.putIfAbsent(year, () => []).add(board);
        }

        List<QuestionYearBody> questionYearBodies = grouped.entries.map((entry) => QuestionYearBody(year: entry.key, board: entry.value)).toList();
        Get.find<QuestionController>().updateQuestionYearBody(questionYearBodies);
      }

      if(widget.questionItem?.options != null && widget.questionItem!.options!.isNotEmpty) {
        Get.find<QuestionController>().updateOption(widget.questionItem!);
      }

    }
  }

  @override
  void dispose() {
    questionTextController.disable();
    explanationController.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => widget.onEditorPointerDown?.call(),
      onPointerUp: (_) => widget.onEditorPointerUp?.call(),
      child: GetBuilder<QuestionController>(builder: (questionController) {
        return Column(children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomRoutePathWidget(titleOnTap: () => Get.toNamed(RouteHelper.getQuestionRoute("question")),
                  title: "question_bank".tr, subWidget: Row(children: [
                    PathItemWidget(title: "add_question".tr,color: Theme.of(context).primaryColor),
                  ]))),

          CustomContainer(showShadow: false, borderRadius: 5,
            child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall,
              crossAxisAlignment: CrossAxisAlignment.start, children: [

              ResponsiveGridList(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  desiredItemWidth: 200,
                  minSpacing: Dimensions.paddingSizeDefault, children: [
                    if(questionController.selectedQuestionType != null)...[
                      const QuestionBankSelectClassWidget(),
                      const QuestionBankSelectGroupWidget(),
                      const QuestionBankSelectSubjectWidget(),
                      const QuestionBankSelectChapterWidget(),
                      const SelectQuestionCategoryWidget(),
                      const QuestionBankSelectLevelWidget(),
                      const QuestionBankSelectTopicWidget(),
                      const QuestionBankSelectTypeWidget(),
                      const QuestionBankSelectSourceWidget(),
                      const QuestionBankSelectSubSourceWidget(),
                      const QuestionBankSelectYearWidget(),
                    ],
                  ]
              ),
              const QuestionYearSelectionWidget(),



              CustomRichEditor(title: "question_text".tr,
                hintText: "question_text".tr, controller: questionTextController,
                height: 200,),


                const OptionManagementWidget(),

              CustomRichEditor(title: "explanation".tr,
                  controller: explanationController, height: 250),


              questionController.isLoading? const Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: SizedBox(width: 200,
                    child: CustomButton(onTap: () async {

                      String? questionText = await questionTextController.getText();
                      String explanation = await explanationController.getText();
                      int? selectedClassId = Get.find<QuestionBankClassController>().selectedClassItem?.id;
                      int? selectedGroupId = Get.find<QuestionBankGroupController>().selectedGroupItem?.id;
                      int? selectedSubjectId = Get.find<QuestionBankSubjectController>().selectSubjectItem?.id;
                      int? selectedChapterId = Get.find<QuestionBankChapterController>().selectChapterItem?.id;
                      int? selectedCategoryId = Get.find<QuestionCategoryController>().selectedQuestionCategoryItem?.id;
                      int? selectedTopicId = Get.find<QuestionBankTopicsController>().selectQuestionBankTopicItem?.id;
                      int? selectedTypeId = Get.find<QuestionBankTypesController>().selectTypeItem?.id;
                      int? selectedLevelId = Get.find<QuestionBankLevelController>().selectedLevelItem?.id;
                      int? selectedSourceId = Get.find<QuestionBankSourcesController>().selectedQuestionBankSourcesItem?.id;
                      int? selectedSubSourceId = Get.find<QuestionBankSubSourcesController>().selectedQuestionBankSubSourcesItem?.id;
                      int? selectedYearId = Get.find<QuestionBankYearController>().selectYearItem?.id;
                      List<QuestionYearBody>? questionYearBody = questionController.questionYearBodyList;
                      List<String> options = questionController.options.map((e) => e.controller.text.trim()).toList();
                      List<bool> isSelected = questionController.options.map((e) => e.isSelected).toList();

                      List<String> selectedOptions = [];
                      if(questionController.selectedQuestionType == "multiple_choice"){
                        for(int i = 0; i < options.length; i++) {
                          if (isSelected[i]) {
                            selectedOptions.add(options[i]);
                          }
                        }
                      }


                      QuestionBody questionBody = QuestionBody(
                        questionBankClassId: selectedClassId,
                        questionBankGroupId: selectedGroupId,
                        questionBankSubjectId: selectedSubjectId,
                        questionBankChapterId: selectedChapterId,
                        questionCategoryId: selectedCategoryId,
                        question: questionText,
                        type: "${questionController.selectedQuestionType}",
                        explanation: explanation,
                        options: options,
                        correctAnswer: selectedOptions,
                        questionYear: questionYearBody,
                        types: selectedTypeId != null? [selectedTypeId] : [],
                        levels: selectedLevelId != null? [selectedLevelId] : [],
                        topics: selectedTopicId != null? [selectedTopicId] : [],
                        sources: selectedSourceId != null? [selectedSourceId] : [],
                        subSources: selectedSubSourceId != null? [selectedSubSourceId] : [],
                        session: selectedYearId != null? [selectedYearId] : [],
                        sMethod: widget.questionItem != null? "PUT" : "POST");

                      if(questionText.isEmpty){
                          showCustomSnackBar("question_text_is_empty".tr);
                        }
                        else if(selectedClassId == null) {
                          showCustomSnackBar("select_class".tr);
                        }
                        else if(selectedGroupId == null) {
                          showCustomSnackBar("select_group".tr);
                        }
                        else if(selectedSubjectId == null) {
                          showCustomSnackBar("select_subject".tr);
                        }
                        else{
                          if(widget.questionItem != null){
                            questionController.editQuestion(questionBody, widget.questionItem!.id!);
                          }else{
                            questionController.createQuestion(questionBody).then((val){
                              if(val.statusCode == 200){
                                questionTextController.clear();
                                explanationController.clear();
                              }
                            });
                          }

                        }
                          }, text: widget.questionItem != null? "update".tr : "save_and_continue".tr),
                        ))
                  ],),
                ),
              ],
            );
          }
      ),
    );
  }
}
