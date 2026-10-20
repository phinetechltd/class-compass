import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/print_question_paper_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_paper_heading_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_paper_item_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class QuestionPaperCreateScreen extends StatefulWidget {
  const QuestionPaperCreateScreen({super.key});

  @override
  State<QuestionPaperCreateScreen> createState() => _QuestionPaperCreateScreenState();
}

class _QuestionPaperCreateScreenState extends State<QuestionPaperCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CustomAppBar(),
    body: CustomWebScrollView(slivers: [
      SliverToBoxAdapter(
          child: GetBuilder<QuestionController>(builder: (questionController) {
            QuestionModel? questionModel = questionController.questionModel;
            var question = questionModel?.data;

            List<QuestionItem> selectedQuestions = question!.data!
                .where((q) => q.selectForQuiz == true)
                .toList();


            return Column(children: [
              SectionHeaderWithPath(sectionTitle: "question_paper".tr,
              widget: Row(spacing: Dimensions.paddingSizeSmall, children: [
                InkWell(onTap: ()=> questionController.changeQuestionPaperColumn(2),
                    child: Icon(Icons.grid_view_rounded, size: 20,color: Theme.of(context).hintColor)),
                InkWell(onTap: ()=> questionController.changeQuestionPaperColumn(1),
                    child: Icon(Icons.list, size: 20,color: Theme.of(context).hintColor)),
                SizedBox(width: 150, child: CustomButton(
                    onTap: (){
                      generateQuestionPaper(context, selectedQuestions, questionController,
                      columns: questionController.questionPaperColumn);
                    }, text: "download".tr,
                    icon: const Icon(Icons.download, color: Colors.white,)))

              ]),),
              const QuestionPaperHeadingItem(),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              const QuestionPaperHeadingWidget(),

              MasonryGridView.builder(
                  itemCount: selectedQuestions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: questionController.questionPaperColumn),
                  itemBuilder: (_, index){
                    return QuestionPaperItemWidget(questionItem: selectedQuestions[index], index: index);
                  })
            ]);
          }
      ))
    ]),);
  }
}
