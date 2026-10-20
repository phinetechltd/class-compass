
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/screens/create_new_question_screen.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_list_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuestionScreen extends StatefulWidget {
  final String? page;
  final String? courseId;
  const QuestionScreen({super.key, this.page = "question", this.courseId});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "question".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child: QuestionListWidget(scrollController: scrollController,
              fromQuiz: widget.page == "quiz"),)
        ],),


        floatingActionButton: ResponsiveHelper.isDesktop(context)?
        GetBuilder<QuestionController>(
          builder: (questionController) {
            return widget.page == "quiz"?
            Row(spacing: Dimensions.paddingSizeDefault, mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    heroTag: 'create_question_paper',
                    onPressed: (){
                  Get.toNamed(RouteHelper.getCreateQuestionPaperRoute());
                      //quizSettingController.addQuestionToQuiz(questionController.selectedQuestionIds, quizSettingController.createdQuizId!, widget.courseId!);
                    }, label: Text("${"create_question_paper".tr} - ${questionController.selectedQuestionIds.length}",
                        style: textRegular.copyWith(color: Colors.white,
                            fontSize: Dimensions.fontSizeDefault))),

                FloatingActionButton.extended(backgroundColor: Theme.of(context).colorScheme.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    heroTag: 'clear_all',
                    onPressed: (){
                      questionController.removeAllSelectedQuestionIds();
                    }, label: Text("${"clear_all".tr} ",
                        style: textRegular.copyWith(color: Colors.white,
                            fontSize: Dimensions.fontSizeDefault))),
              ],
            ):const SizedBox();
          }
        ) :
        CustomFloatingButton(title: "add",
            onTap: ()=> Get.to(()=> const CreateNewQuestionScreen()))
    );
  }
}



