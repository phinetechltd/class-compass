import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/model/question_bank_chapter_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/select_question_bank_subject_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankChapterWidget extends StatefulWidget {
  final QuestionBankChapterItem? item;
  const CreateNewQuestionBankChapterWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankChapterWidget> createState() => _CreateNewQuestionBankChapterWidgetState();
}

class _CreateNewQuestionBankChapterWidgetState extends State<CreateNewQuestionBankChapterWidget> {
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
    return GetBuilder<QuestionBankChapterController>(
        builder: (chapterController) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_chapter".tr : "add_new_chapter".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "chapter_name".tr,
                controller: nameController,
                hintText: "enter_chapter_name".tr,),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              QuestionBankSelectSubjectWidget(title: "select_subject".tr),



              chapterController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    int? subjectId = Get.find<QuestionBankSubjectController>().selectSubjectItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else if(subjectId == null){
                      showCustomSnackBar("subject_is_empty".tr);
                    }
                    else{
                      Get.back();
                      if(update){
                        chapterController.editQuestionBankChapter(name, subjectId,  widget.item!.id!);
                      }else{
                        chapterController.createQuestionBankChapter(name, subjectId).then((val){
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
