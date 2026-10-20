import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/create_new_question_widget.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionScreen extends StatefulWidget {
  final QuestionItem? questionItem;
  const CreateNewQuestionScreen({super.key, this.questionItem});

  @override
  State<CreateNewQuestionScreen> createState() => _CreateNewQuestionScreenState();
}

class _CreateNewQuestionScreenState extends State<CreateNewQuestionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_question".tr),
      body: GetBuilder<QuestionController>(
        builder: (questionController) {
          return Listener(
            child: CustomWebScrollView( slivers: [

              SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CreateNewQuestionWidget(questionItem: widget.questionItem,
                  onEditorPointerDown: questionController.disableOuterScroll,
                  onEditorPointerUp: questionController.enableOuterScroll,),
              ),)
            ],),
          );
        }
      ),
    );
  }
}
