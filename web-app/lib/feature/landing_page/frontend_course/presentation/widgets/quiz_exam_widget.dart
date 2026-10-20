import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_submit_body.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/question_item_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuizExamWidget extends StatefulWidget {
  const QuizExamWidget({super.key});

  @override
  State<QuizExamWidget> createState() => _QuizExamWidgetState();
}

class _QuizExamWidgetState extends State<QuizExamWidget> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _questionKeys = [];




  bool _isTimerInitialized = false;
  Timer? _timer;
  int _seconds = 0;

  String get timeLeft {
    final int hours = _seconds ~/ 3600;
    final int minutes = (_seconds % 3600) ~/ 60;
    final int seconds = _seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }



  void _initializeTimer() {
    if (_isTimerInitialized) return;

    final courseController = Get.find<FrontendCourseController>();
    final quiz = courseController.quizDetailsModel?.data?.quiz;
    final startedTimeStr = courseController.quizStartModel?.startedAt;

    if (quiz != null &&
        quiz.timeLimitValue != null &&
        quiz.timeLimitUnit != null &&
        startedTimeStr != null &&
        startedTimeStr.isNotEmpty) {
      try {
        final startedUtc = DateTime.parse(startedTimeStr); // parsed as UTC
        final startedLocal = startedUtc.toLocal();

        int totalSeconds;
        switch (quiz.timeLimitUnit!.toLowerCase()) {
          case "minutes":
          case "minute":
            totalSeconds = quiz.timeLimitValue! * 60;
            break;
          case "hours":
          case "hour":
            totalSeconds = quiz.timeLimitValue! * 3600;
            break;
          case "days":
          case "day":
            totalSeconds = quiz.timeLimitValue! * 86400;
            break;
          case "weeks":
          case "week":
            totalSeconds = quiz.timeLimitValue! * 604800;
            break;
          default:
            totalSeconds = 0;
        }

        final endTime = startedLocal.add(Duration(seconds: totalSeconds));
        final now = DateTime.now();
        final remaining = endTime.difference(now).inSeconds;
        _seconds = remaining > 0 ? remaining : 0;

        log("⏳ Timer started with $_seconds seconds remaining");
        _startTimer();
        _isTimerInitialized = true;
        setState(() {});
        return;
      } catch (e, st) {
        log("❌ Timer Init Error: $e\n$st");
      }
    }

    log("❌ Timer data missing or invalid");
    _seconds = 0;
    _isTimerInitialized = true;
    setState(() {});
  }




  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 1) {
        timer.cancel();
        _handleTimeExpiry();
      } else {
        _seconds -= 1;
        setState(() {});
      }
    });
  }

  void _handleTimeExpiry() {
    stopTimer();
  }

  void stopTimer() {
    _timer?.cancel();
    _seconds = 0;
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }




  int _currentScrollIndex = 0;
  void scrollToQuestion(int index) {
    const double estimatedItemHeight = 300.0;
    final double offset = index * estimatedItemHeight;
    _scrollController.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    const double estimatedItemHeight = 300.0; // adjust to your item height

    final offset = _scrollController.offset;
    final index = (offset / estimatedItemHeight).floor();

    if (index != _currentScrollIndex) {
      setState(() {
        _currentScrollIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _waitForQuizStartDataThenInitTimer();
    });
  }

  void _waitForQuizStartDataThenInitTimer() async {
    final courseController = Get.find<FrontendCourseController>();
    while (courseController.quizStartModel == null ||
        courseController.quizDetailsModel == null ||
        courseController.quizDetailsModel!.data?.quiz == null) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
    _initializeTimer();
  }





  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        QuizDetailsModel? quizDetailsModel = courseController.quizDetailsModel;
        var question = quizDetailsModel?.data?.questions;

        log("result visibility is===>${quizDetailsModel?.data?.quiz?.resultVisibility}");

        if (_questionKeys.length != (question?.length ?? 0)) {
          _questionKeys.clear();
          if (question != null && question.isNotEmpty) {
            for (int i = 0; i < question.length; i++) {
              _questionKeys.add(GlobalKey());
            }
          }
        }


        double marksPerQuestion = double.tryParse(quizDetailsModel?.data?.quiz?.marksPerQuestion?.toString() ?? '0') ?? 0.0;
        int numberOfQuestions = quizDetailsModel?.data?.questions?.length ?? 0;
        double totalMarks = marksPerQuestion * numberOfQuestions;
        int answeredCount = 0;
        List<Answers> answerList = [];
        if (courseController.quizDetailsModel != null && courseController.quizDetailsModel!.data != null && courseController.quizDetailsModel!.data!.questions != null)
        {
          for (var question in courseController.quizDetailsModel!.data!.questions!) {
            if (question.options != null && question.options!.isNotEmpty) {
              bool isAnswered = question.options!.any((option) => option.isSelected || option.isCorrect);
              if (isAnswered) {
                answeredCount++;
              }
            }

            if (question.options != null && question.options!.isNotEmpty) {
              List<String> isSelected = question.options!.map((option) {
                if (option.isSelected) {
                  return "true";
                } else if (option.isCorrect) {
                  return "false";
                }
                return "N/A";
              }).whereType<String>().toList();
              answerList.add(Answers(questionId: question.id, selectedOptions: isSelected));
            }
          }

        }

        return Column(children: [
          CustomContainer(horizontalPadding: 0, verticalPadding: 0,
              showShadow: false, borderRadius: Dimensions.paddingSizeSmall,
              child: Column(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: 5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, spacing: Dimensions.paddingSizeSmall, children: [
                    courseController.loading? const Center(child: CircularProgressIndicator()):
                    Row(spacing: Dimensions.paddingSizeSmall,
                      children: [
                        IconButton(onPressed: (){
                          courseController.toggleLeftMenu();
                        }, icon: Icon(Icons.menu_rounded, color: systemLandingPagePrimaryColor(), size: 25)),

                        CustomContainer(onTap: (){
                          QuizSubmitBody body = QuizSubmitBody(
                              quizId: courseController.quizDetailsModel?.data?.quiz?.id,
                              attemptId: courseController.quizStartModel?.attemptId,
                              answers: answerList);
                          if(courseController.quizDetailsModel?.data?.quiz?.id == null){
                            showCustomSnackBar("Maximum Attempted Reached");
                          }else if(answeredCount>0){
                            courseController.quizAnswerSubmit(body);
                          }else{
                            showCustomSnackBar("Please answer at least one question before submitting.");
                          }
                        },
                            showShadow : false, border: Border.all(color : systemLandingPagePrimaryColor()),
                            borderRadius: 3,verticalPadding: 5, color: systemLandingPagePrimaryColor(), horizontalPadding: 20,
                            child: Text("submit".tr, style: textRegular.copyWith(color: Colors.white))),
                      ],
                    ),



                    (quizDetailsModel?.data?.quiz?.resultVisibility != "after_review")?
                    Column(children: [
                      Text(timeLeft, style: textBold.copyWith(color: systemLandingPagePrimaryColor(), fontSize: Dimensions.fontSizeLarge)),
                      Text("Time left", style : textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: systemLandingPagePrimaryColor()))
                    ]):Text("practise_mode".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: systemLandingPagePrimaryColor())),

                    if(ResponsiveHelper.isDesktop(context))
                    Row(spacing: Dimensions.paddingSizeSmall,
                      children: [
                        Text("Answered: $answeredCount / ${courseController.quizDetailsModel?.data?.questions?.length ?? 0}",
                            style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                        IconButton(onPressed: (){
                          courseController.toggleLeftMenu();
                        }, icon: Icon(Icons.clear, color: Theme.of(context).primaryColor, size: 25)),
                      ],
                    ),



                  ])),
                if(!ResponsiveHelper.isDesktop(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(spacing: Dimensions.paddingSizeSmall,
                            children: [
                              Text("Answered: $answeredCount / ${courseController.quizDetailsModel?.data?.questions?.length ?? 0}",
                                  style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                              IconButton(onPressed: (){
                                courseController.toggleLeftMenu();
                              }, icon: Icon(Icons.clear, color: Theme.of(context).primaryColor, size: 25)),
                            ],
                          ),
                        ),
                        CustomContainer(verticalPadding: 3,borderRadius: 3, horizontalPadding: 15,
                          child: Text("back".tr, style: textRegular),onTap: ()=> Get.back(),)
                      ],
                    ),
                  ),

                if(quizDetailsModel?.data?.quiz?.resultVisibility != "after_review")
              CustomContainer(width: Get.width,showShadow: false, color: const Color(0xFFEAFBF2), borderRadius: 0,
                  child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,spacing: Dimensions.paddingSizeExtraSmall,
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.green, size: 16,),
                      Text("${"exam_instructions".tr}: ", style: textBold.copyWith()),
                      Flexible(child: Text("Full marks $totalMarks Negative marking: -${quizDetailsModel?.data?.quiz?.negativeMarksPerWrongAnswer??'0'} per wrong answer. Please read each question carefully and select the most appropriate answer. ",
                            style: textRegular.copyWith(color : Theme.of(context).hintColor, fontSize: Dimensions.fontSizeExtraSmall)),
                      ),
                    ],
                  ))),
            ],
          )),

          Expanded(child: Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CustomContainer(width: Get.width,showShadow: false,borderRadius: 0, child : quizDetailsModel != null? (question!.isNotEmpty)?
                  ListView.builder(
                    controller: _scrollController,
                      itemCount: question.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Container(key: _questionKeys[index],
                          child: QuestionItemWidget(index: index, questionItem: question[index], practiseMode: quizDetailsModel.data?.quiz?.resultVisibility == "after_review",));
                      }):
                  Padding(padding: ThemeShadow.getPadding(),
                    child: const Center(child: NoDataFound()),):
                  Padding(padding:ThemeShadow.getPadding(),
                      child: const Center(child: CircularProgressIndicator()))),
              ),

              if(ResponsiveHelper.isDesktop(context))
              CustomContainer(borderRadius: 10, width: 200,child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                spacing: Dimensions.paddingSizeDefault,
                children: [
                  Text("Question Navigation", style: textSemiBold.copyWith(),),
                  GridView.builder(
                    itemCount: question?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,mainAxisSpacing: 5, crossAxisSpacing: 5),
                      itemBuilder: (_, index){
                    return CustomContainer(onTap: () => scrollToQuestion(index), borderRadius: 5, horizontalPadding: 5,verticalPadding: 5,
                      showShadow: false, color: question![index].options!.any((option) => option.isSelected || option.isCorrect)? Theme.of(context).primaryColor.withValues(alpha: .2) : Theme.of(context).highlightColor,
                      child: Center(child: Text("${index+1}", style: textBold.copyWith(color: question[index].options!.any((option) => option.isSelected || option.isCorrect)? Theme.of(context).primaryColor : Theme.of(context).hintColor))));
                      }),

                  Column(spacing: 5, children: [
                    Row(spacing: Dimensions.paddingSizeExtraSmall, children: [Icon(Icons.check_circle, color: Theme.of(context).primaryColor,size: 16,),
                      const Text("Answered", style: textRegular)
                    ],),
                    Row(spacing: Dimensions.paddingSizeExtraSmall, children: [Icon(Icons.cancel, color: Theme.of(context).hintColor, size: 16,),
                      const Text("Unanswered", style: textRegular)
                    ],)
                  ],)

                ],
              ),)
            ],
          ),
          )
        ]);
      }
    );
  }
}
