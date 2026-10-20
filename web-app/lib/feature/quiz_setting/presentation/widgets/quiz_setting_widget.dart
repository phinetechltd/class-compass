import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/custom_rich_editor.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/quiz_setting/domain/model/quiz_setting_model.dart';
import 'package:class_compass/feature/quiz_setting/logic/quiz_setting_controller.dart';
import 'package:class_compass/feature/quiz_setting/presentation/widgets/quiz_setting_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class QuizSettingWidget extends StatefulWidget {
  const QuizSettingWidget({super.key});

  @override
  State<QuizSettingWidget> createState() => _QuizSettingWidgetState();
}

class _QuizSettingWidgetState extends State<QuizSettingWidget> {
  TextEditingController examNameController = TextEditingController();
  HtmlEditorController examDescriptionController = HtmlEditorController();
  HtmlEditorController examGuideLineController = HtmlEditorController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController timeLimitValueController = TextEditingController();
  TextEditingController marksPerQuestionController = TextEditingController();
  TextEditingController negativeMarksPerQuestionController = TextEditingController();
  TextEditingController passMarksController = TextEditingController();
  TextEditingController attemptController = TextEditingController();

  bool update = false;

  bool isValidJson(String source) {
    try {
      final decoded = jsonDecode(source);
      return decoded is List; // Quill Delta JSON is a List of operations
    } catch (_) {
      return false;
    }
  }
  String convertToLocal(String utcString) {
    final utcDateTime = DateTime.parse(utcString);
    final localDateTime = utcDateTime.toLocal();
    return localDateTime.toString().split('.').first; // removes .000Z
  }
  @override
  void initState() {
    Contents? contents = Get.find<CourseController>().selectedContent;
    var courseController = Get.find<CourseController>();
    if(contents != null){
      update = true;
      examNameController.text = contents.title??'';

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 2000), () async {
           examDescriptionController.setText(contents.description??'');
           examGuideLineController.setText(contents.guidelines??'');
        });
      });
      passwordController.text = contents.accessPassword ?? '';
      timeLimitValueController.text = contents.timeLimitValue?.toString() ?? '';
      marksPerQuestionController.text = contents.marksPerQuestion?.toString() ?? '';
      negativeMarksPerQuestionController.text = contents.negativeMarksPerWrongAnswer?.toString() ?? '';
      passMarksController.text = contents.passMark?.toString() ?? '';
      attemptController.text = contents.attemptsAllowed?.toString() ?? '';
      courseController.selectedDateTime = contents.startTime != null? DateTime.parse(contents.startTime!) : null;
      courseController.toSelectedDateTime = contents.endTime != null? DateTime.parse(contents.endTime!): null;
      courseController.selectedTimeLimitType = contents.timeLimitUnit ?? 'minutes';
      courseController.selectedTimeExpiredType = contents.onExpiry == "auto_submit"?  courseController.timeExpiredTypeList[0] : contents.onExpiry == "prevent_submit"? courseController.timeExpiredTypeList[1] : courseController.timeExpiredTypeList[2];
      courseController.selectedAttemptType = contents.attemptsAllowed == null? "unlimited" : "custom";
      courseController.selectedLayoutType = contents.layoutPages == 1? courseController.layoutTypes[0] : courseController.layoutTypes[1];
      courseController.selectedQuestionShuffleType = contents.shuffleQuestions == true? "Yes" : "No";
      courseController.selectedShuffleQuestionOption = contents.shuffleOptions == true? "Yes" : "No";
      courseController.selectedResultShowType = contents.resultVisibility == "immediate"? courseController.resultShowListType[0] :
          contents.resultVisibility == "after_review"? courseController.resultShowListType[1] : courseController.resultShowListType[2];
      courseController.selectedResultShowTypeForDatabase = contents.resultVisibility;
      courseController.selectedSecurityType = contents.accessType ?? 'none';
      courseController.displayDescriptionOnCourse = contents.showDescriptionOnCoursePage ?? false;
      courseController.hasTimeLimit = contents.hasTimeLimit ?? false;
      courseController.openQuizEnabled = contents.startTime != null;
      courseController.closeQuizEnabled = contents.endTime != null;
      courseController.formatedSelectedDateTime = courseController.selectedDateTime != null
          ? "${Get.find<CourseController>().selectedDateTime?.day}/${Get.find<CourseController>().selectedDateTime?.month}/${Get.find<CourseController>().selectedDateTime?.year} ${Get.find<CourseController>().selectedDateTime?.hour}:${Get.find<CourseController>().selectedDateTime?.minute}"
          : "select_date".tr;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    examDescriptionController.disable();
    examGuideLineController.disable();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Column(children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomRoutePathWidget(title: "course_management".tr, subWidget: Row(children: [
              PathItemWidget(title: "courses".tr,color: Theme.of(context).primaryColor),
              PathItemWidget(title: "add_an_activity_or_resource".tr,color: Theme.of(context).primaryColor),
            ])),
          ),

          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CustomContainer(showShadow: false, borderRadius: Dimensions.paddingSizeExtraSmall,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Adding a new online activity to Chapter-1", style: textSemiBold.copyWith()),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              ExpansionTile(backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
                  onExpansionChanged: (val){
                    courseController.toggleSetting(val);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall), side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: .125))),
                  title: CustomContainer(verticalPadding: 5,
                      showShadow: false, color:courseController.isSettingExpanded? Colors.transparent : const Color(0xFFE4EAF5),
                      borderRadius: 5, border: courseController.isSettingExpanded? null : Border.all(width: .5, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .25)),
                  child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                    children: [
                      courseController.isSettingExpanded?
                      Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor,):
                      Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor,),
                      Expanded(child: CustomTitle(title: "general", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,)),
                    ],
                  )),

                  showTrailingIcon: false, tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  children: [
                    CustomContainer(showShadow: false, child: Column(spacing: Dimensions.paddingSizeSmall,children: [
                      QuizSettingItemWidget(title: "exam_name".tr, child: CustomTextField(controller: examNameController)),
                      QuizSettingItemWidget(title: "exam_description".tr,
                          child: CustomRichEditor(controller: examDescriptionController, hintText: "description".tr, height: 100,)),

                      QuizSettingItemWidget(title: "exam_guidelines".tr,
                          child: CustomRichEditor(controller: examGuideLineController, height: 100, )),

                      Row(children: [
                          const Expanded(flex: 2, child: SizedBox()),
                          Expanded(flex: 10,
                            child: Row(children: [
                              Checkbox(value: courseController.displayDescriptionOnCourse,
                                  onChanged: (value) {
                                    courseController.toggleDisplayDescriptionOnCourse(remember: value??false);
                                  },
                                  activeColor: Theme.of(context).primaryColor, checkColor: Theme.of(context).cardColor,
                                  side: BorderSide(color: Theme.of(context).primaryColor,width: 2)),

                              Expanded(child: Text("display_description_on_course".tr,style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),)),

                            ]),
                          ),
                        ]),
                    ]))
                  ]),



              ExpansionTile(backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
                  onExpansionChanged: (val){
                    courseController.toggleTime(val);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: .125))),
                  title: CustomContainer(verticalPadding: 5,
                      showShadow: false,  color:courseController.isTimeExpanded? Colors.transparent : const Color(0xFFE4EAF5),
                      borderRadius: 5, border: courseController.isTimeExpanded? null : Border.all(width: .5, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .25)),
                  child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                    children: [
                      courseController.isTimeExpanded?
                      Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor,):
                      Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor,),
                      Expanded(child: CustomTitle(title: "timing", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,)),
                    ],
                  )),

                  showTrailingIcon: false, tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  children: [
                    CustomContainer(showShadow: false, child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                      QuizSettingItemWidget(title: "open_the_quiz".tr, child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        InkWell(onTap: (){
                          if(courseController.openQuizEnabled){
                            courseController.showDateTimePicker(context: context);
                          }
                        },
                            child: CustomContainer( verticalPadding: 5,
                              showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor, width: .125),
                              child: Text(courseController.formatedSelectedDateTime??"select_date".tr, style: textRegular),)),
                        Row(children: [
                          Checkbox(value: courseController.openQuizEnabled,
                              onChanged: (value) {
                                courseController.toggleOpenQuizEnabled(value??false);
                              },
                              activeColor: Theme.of(context).primaryColor, checkColor: Theme.of(context).cardColor,
                              side: BorderSide(color: Theme.of(context).primaryColor,width: 2)),

                          Text("enable".tr,style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),),

                        ]),

                      ])),

                      QuizSettingItemWidget(title: "close_the_quiz".tr, child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        InkWell(onTap: (){
                          if(courseController.closeQuizEnabled){
                            courseController.showDateTimePicker(context: context, quizClose: true);
                          }
                        },
                            child: CustomContainer( verticalPadding: 5,
                              showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor, width: .125),
                              child: Text(courseController.formatedToSelectedDateTime??"select_date".tr, style: textRegular),)),
                        Row(children: [
                          Checkbox(value: courseController.closeQuizEnabled,
                              onChanged: (value) {
                                courseController.toggleCloseQuizEnabled(value??false);
                              },
                              activeColor: Theme.of(context).primaryColor, checkColor: Theme.of(context).cardColor,
                              side: BorderSide(color: Theme.of(context).primaryColor,width: 2)),

                          Text("enable".tr,style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),),

                        ]),

                      ])),

                      QuizSettingItemWidget(title: "time_limit".tr, child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        SizedBox(width: 120, child: CustomTextField(hintText: "0",
                            inputFormatters: [AppConstants.numberFormat],
                          inputType: TextInputType.number,
                            isEnabled: courseController.hasTimeLimit,
                            controller: timeLimitValueController)),
                        SizedBox(width: 120,
                          child: CustomDropdown(width: Get.width, title: "select".tr,
                            items: courseController.timeLimitTypeList,
                            selectedValue: courseController.selectedTimeLimitType,
                            onChanged: courseController.hasTimeLimit? (val){
                              courseController.setTimeLimitType(val!);
                            } : null,
                          ),
                        ),
                        Row(children: [
                          Checkbox(value: courseController.hasTimeLimit,
                              onChanged: (value) {
                                courseController.toggleHasTimeLimit(remember: value??false);
                              },
                              activeColor: Theme.of(context).primaryColor, checkColor: Theme.of(context).cardColor,
                              side: BorderSide(color: Theme.of(context).primaryColor,width: 2)),

                          Text("enable".tr,style: textRegular.copyWith(color: Theme.of(context).colorScheme.secondary),),

                        ]),


                      ])),
                      QuizSettingItemWidget(title: "when_time_expires".tr, child: Row(
                        children: [
                          SizedBox(width: 620,
                            child: CustomDropdown(width: Get.width, title: "select".tr,
                              items: courseController.timeExpiredTypeList,
                              selectedValue: courseController.selectedTimeExpiredType,
                              onChanged: (val){
                                courseController.setTimeExpiredType(val!);
                              },
                            ),
                          ),
                        ],
                      ),),


                    ]))
                  ]),

              ExpansionTile(backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
                  onExpansionChanged: (val){
                    courseController.toggleTime(val);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: .125))),
                  title: CustomContainer(verticalPadding: 5,
                      showShadow: false,  color:courseController.isTimeExpanded? Colors.transparent : const Color(0xFFE4EAF5),
                      borderRadius: 5, border: courseController.isTimeExpanded? null : Border.all(width: .5, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .25)),
                      child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                        children: [
                          courseController.isTimeExpanded?
                          Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor,):
                          Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor,),
                          Expanded(child: CustomTitle(title: "grade", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,)),
                        ],
                      )),

                  showTrailingIcon: false, tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  children: [
                    CustomContainer(showShadow: false, child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                      QuizSettingItemWidget(title: "marks_per_question".tr, child: Row(
                        children: [
                          SizedBox(width: 200, child: CustomTextField(hintText: "0",
                            inputFormatters: [AppConstants.numberFormat],
                            inputType: TextInputType.number,
                            controller: marksPerQuestionController,)),
                        ],
                      )),
                      QuizSettingItemWidget(title: "negative_marks_per_question_answer".tr, child: Row(
                        children: [
                          SizedBox(width: 200, child: CustomTextField(hintText: "0",
                            inputFormatters: [AppConstants.numberFormat],
                            inputType: TextInputType.number,
                            controller: negativeMarksPerQuestionController,)),
                        ],
                      )),
                      QuizSettingItemWidget(title: "pass_marks".tr,  child: Row(
                      children: [
                      SizedBox(width: 200, child: CustomTextField(hintText: "0",
                        inputFormatters: [AppConstants.numberFormat],
                        inputType: TextInputType.number,
                        controller: passMarksController,)),
                    ],
                    )),
                      QuizSettingItemWidget(title: "attempt_allowed".tr, child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        CustomContainer(onTap: ()=> courseController.setAttemptType("unlimited"),
                          showShadow: false, borderRadius: 3, border: Border.all(width: .2, color: Theme.of(context).primaryColor),
                          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                            Icon(courseController.selectedAttemptType == "unlimited"? Icons.radio_button_checked : Icons.radio_button_off, size: 16,
                                color: courseController.selectedAttemptType == "unlimited"? Theme.of(context).primaryColor: Theme.of(context).hintColor),
                            Text(courseController.attemptType.first),
                          ],
                        ),),
                        CustomContainer(onTap: ()=> courseController.setAttemptType("custom"),
                          showShadow: false, borderRadius: 3, border: Border.all(width: .2, color: Theme.of(context).primaryColor),
                          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                            Icon(courseController.selectedAttemptType == "custom"? Icons.radio_button_checked : Icons.radio_button_off, size: 16,
                                color: courseController.selectedAttemptType == "custom"? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                            Text(courseController.attemptType.last),
                          ],
                        ),),
                        if(courseController.selectedAttemptType == "custom")
                        SizedBox(width: 130, child: CustomTextField(hintText: "enter_number".tr, controller: attemptController,)),

                      ])),

                      QuizSettingItemWidget(title: "result_show".tr, child: Row(
                        children: [
                          SizedBox(width: 320,
                            child: CustomDropdown(width: Get.width, title: "select".tr,
                              items: courseController.resultShowListType,
                              selectedValue: courseController.selectedResultShowType,
                              onChanged: (val){
                                courseController.setResultShowType(val!);
                              },
                            ),
                          ),
                        ],
                      ),),


                    ]))
                  ]),
              ExpansionTile(backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
                  onExpansionChanged: (val){
                    courseController.toggleTime(val);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: .125))),
                  title: CustomContainer(verticalPadding: 5,
                      showShadow: false,  color:courseController.isTimeExpanded? Colors.transparent : const Color(0xFFE4EAF5),
                      borderRadius: 5, border: courseController.isTimeExpanded? null : Border.all(width: .5, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .25)),
                      child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                        children: [
                          courseController.isTimeExpanded?
                          Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor,):
                          Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor,),
                          Expanded(child: CustomTitle(title: "layout_tab", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,)),
                        ],
                      )),

                  showTrailingIcon: false, tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  children: [
                    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,showShadow: false, child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                      QuizSettingItemWidget(title: "question_layout_page".tr, child: Row(children: [
                          SizedBox(width: 200,
                            child: CustomDropdown(width: Get.width, title: "select".tr,
                              items: courseController.layoutTypes,
                              selectedValue: courseController.selectedLayoutType,
                              onChanged: (val){
                                courseController.setLayoutType(val!);
                              },
                            ),
                          ),
                        ],
                      )),
                      QuizSettingItemWidget(title: "shuffle_within_question".tr, child: Row(children: [
                          SizedBox(width: 200,
                            child: CustomDropdown(width: Get.width, title: "select".tr,
                              items: courseController.questionShuffleTypeList,
                              selectedValue: courseController.selectedQuestionShuffleType,
                              onChanged: (val){
                                courseController.setQuestionShuffleType(val!);
                              },
                            ),
                          ),
                        ],
                      )),
                      QuizSettingItemWidget(title: "shuffle_question_option".tr,  child: Row(children: [
                        SizedBox(width: 200,
                          child: CustomDropdown(width: Get.width, title: "select".tr,
                            items: courseController.shuffleQuestionOption,
                            selectedValue: courseController.selectedShuffleQuestionOption,
                            onChanged: (val){
                              courseController.setShuffleQuestionOption(val!);
                            },
                          ),
                        ),
                    ],
                    )),
                    ]))
                  ]),
              ExpansionTile(backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
                  onExpansionChanged: (val){
                    courseController.toggleTime(val);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: .125))),
                  title: CustomContainer(verticalPadding: 5,
                      showShadow: false,  color:courseController.isTimeExpanded? Colors.transparent : const Color(0xFFE4EAF5),
                      borderRadius: 5, border: courseController.isTimeExpanded? null : Border.all(width: .5, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .25)),
                      child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                        children: [
                          courseController.isTimeExpanded?
                          Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor,):
                          Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor,),
                          Expanded(child: CustomTitle(title: "security", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,)),
                        ],
                      )),

                  showTrailingIcon: false, tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  children: [
                    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false, child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                      SizedBox(height: 35,
                        child: ListView.builder(
                          itemCount: courseController.securityTypeList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                          return Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                            child: CustomContainer(onTap: ()=> courseController.setSecurityType(courseController.securityTypeList[index]),
                              verticalPadding: 0,
                              showShadow: false, borderRadius: 5, border: Border.all(width: courseController.selectedSecurityType == courseController.securityTypeList[index]? 1 :.25,
                                  color: courseController.selectedSecurityType == courseController.securityTypeList[index]? Theme.of(context).secondaryHeaderColor:Theme.of(context).hintColor),
                              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                                Icon(courseController.selectedSecurityType == courseController.securityTypeList[index]? Icons.radio_button_checked : Icons.radio_button_off, size: 16,
                                    color: courseController.selectedSecurityType == courseController.securityTypeList[index]? Theme.of(context).primaryColor: Theme.of(context).hintColor),
                                Text(courseController.securityTypeList[index].tr, style: textRegular),
                              ],
                              ),),
                          );
                        }),
                      ),

                      Text("set_password".tr, style: textRegular.copyWith()),
                      Row(spacing: Dimensions.paddingSizeSmall, children: [
                        SizedBox(width: 250, child: CustomTextField(isPassword: true, hintText: "••••••••", controller: passwordController)),
                        CustomContainer(onTap: ()=> passwordController.clear(),
                            height: 35, horizontalPadding: 5,verticalPadding: 5,showShadow: false,
                            border: Border.all(width: .125, color: Theme.of(context).hintColor),
                            borderRadius: 3, child: Image.asset( Images.deleteIcon, color: Theme.of(context).textTheme.displaySmall?.color))
                      ])
                    ]))
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  GetBuilder<QuizSettingController>(
                    builder: (quizSettingController) {
                      return CustomButton(width: 180, onTap: () async {

                        String examName = examNameController.text.trim();
                        String examDescription = await examDescriptionController.getText();
                        String examGuideLine = await examGuideLineController.getText();
                        bool displayDescriptionOnCourse = courseController.displayDescriptionOnCourse;
                        String type = "exam";
                        String quizStartTime = courseController.selectedDateTime.toString();
                        String quizEndTime = courseController.toSelectedDateTime.toString();
                        bool hasTimeLimit = courseController.hasTimeLimit;
                        String? timeLimitType = courseController.selectedTimeLimitType;
                        String timeLimitValue = timeLimitValueController.text.trim();
                        String? timeExpiredType = courseController.selectedExpiryTimeTypeForDatabase;
                        String marksPerQuestion = marksPerQuestionController.text.trim();
                        String negativeMarksPerQuestion = negativeMarksPerQuestionController.text.trim();
                        String passMarks = passMarksController.text.trim();
                        String? attemptType = courseController.selectedAttemptType;
                        String? questionLayoutPage = courseController.selectedLayoutType == "All on one page"? "1" : "2";
                        String? shuffleWithinQuestion = courseController.selectedQuestionShuffleType;
                        String? shuffleQuestionOption = courseController.selectedShuffleQuestionOption;
                        String? resultVisibility = courseController.selectedResultShowTypeForDatabase;

                        QuizSettingBody quizSettingBody = QuizSettingBody(
                          courseId: courseController.selectedCourseId,
                          chapterId: courseController.selectedChapterId,
                          title: examName,
                          description: examDescription,
                          guidelines: examGuideLine,
                          showDescriptionOnCoursePage: displayDescriptionOnCourse,
                          type: type,
                          startTime: quizStartTime,
                          endTime: quizEndTime,
                          hasTimeLimit: hasTimeLimit,
                          timeLimitValue: timeLimitValue,
                          timeLimitUnit: timeLimitType,
                          onExpiry: timeExpiredType,
                          marksPerQuestion: marksPerQuestion,
                          negativeMarksPerWrongAnswer: negativeMarksPerQuestion,
                          passMark: passMarks,
                          attemptsAllowed: attemptType == "unlimited"? null : attemptController.text.trim(),
                          layoutPages: questionLayoutPage,
                          shuffleQuestions: shuffleWithinQuestion?.toLowerCase() == "yes",
                          shuffleOptions: shuffleQuestionOption?.toLowerCase() == "yes",
                          resultVisibility: resultVisibility,
                          accessType: courseController.selectedSecurityType,
                          accessPassword: passwordController.text.trim(),
                          sMethod: update? "PUT":"POST"
                        );

                        if(update){
                          quizSettingController.updateQuizSetting(quizSettingBody, courseController.selectedContent!.typeId!);
                        }else {
                          quizSettingController.createQuizSetting(quizSettingBody);
                        }


                      }, text: "save_and_continue".tr);
                    }
                  )
            ])),
          )
        ]);
      }
    );
  }
}
