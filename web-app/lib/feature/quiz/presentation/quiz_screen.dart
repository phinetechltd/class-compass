import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/sub_menu_item_widget.dart';
import 'package:class_compass/feature/menu_section/controller/menu_type_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/screens/question_screen.dart';
import 'package:class_compass/feature/quiz/answer/presentation/screens/answer_screen.dart';
import 'package:class_compass/feature/quiz/quiz_topic/presentation/screens/quiz_topic_screen.dart';
import 'package:class_compass/feature/students_information/student_migration/presentation/screens/student_migration_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.purchase, title: 'topics', widget:  const QuizTopicScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'question', widget:  const QuestionScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'answer', widget:  const AnswerScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'quiz_result', widget:  const StudentMigrationScreen()),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "academic_configuration".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
