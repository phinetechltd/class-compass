import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/select_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/domain/model/question_bank_topics_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankTopicWidget extends StatefulWidget {
  final QuestionBankTopicsItem? item;
  const CreateNewQuestionBankTopicWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankTopicWidget> createState() => _CreateNewQuestionBankTopicWidgetState();
}

class _CreateNewQuestionBankTopicWidgetState extends State<CreateNewQuestionBankTopicWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.name??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTopicsController>(
        builder: (topicController) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_topic".tr : "add_new_topic".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "topic_name".tr,
                controller: nameController,
                hintText: "enter_topic_name".tr,),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              QuestionBankSelectChapterWidget(title: "select_chapter".tr),



              topicController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    int? chapterId = Get.find<QuestionBankChapterController>().selectChapterItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else if(chapterId == null){
                      showCustomSnackBar("chapter_is_empty".tr);
                    }
                    else{
                      if(update){
                        topicController.editQuestionBankTopics(name, chapterId,  widget.item!.id!);
                      }else{
                        topicController.createQuestionBankTopics(name, chapterId).then((val){
                          if(val.statusCode == 200){
                            nameController.clear();
                          }
                        });
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
