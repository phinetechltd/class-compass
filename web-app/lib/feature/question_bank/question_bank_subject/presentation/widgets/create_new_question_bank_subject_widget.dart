import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/select_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/select_question_bank_group_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_body.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/feature/question_bank/question_category/logic/question_category_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/select_question_category_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankSubjectWidget extends StatefulWidget {
  final QuestionBankSubjectItem? item;
  const CreateNewQuestionBankSubjectWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankSubjectWidget> createState() => _CreateNewQuestionBankSubjectWidgetState();
}

class _CreateNewQuestionBankSubjectWidgetState extends State<CreateNewQuestionBankSubjectWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.name??'';
      Get.find<QuestionCategoryController>().setSelectQuestionCategoryItem(QuestionCategoryItem(id: widget.item?.categoryId), notify: false);
      Get.find<QuestionBankClassController>().setSelectClass(QuestionBankClassItem(id: widget.item?.classId, name: widget.item?.className), notify: false);
      Get.find<QuestionBankGroupController>().setSelectGroupItem(QuestionBankGroupItem(id: widget.item?.groupId, name: widget.item?.groupName), notify: false);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSubjectController>(
        builder: (subjectController) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_subject".tr : "add_new_subject".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "subject_name".tr,
                controller: nameController,
                hintText: "enter_subject_name".tr,),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              Row(spacing: Dimensions.paddingSizeDefault, children: [
                const Expanded(child: SelectQuestionCategoryWidget()),
                Expanded(child: QuestionBankSelectClassWidget(title: "select_class".tr)),
                Expanded(child: QuestionBankSelectGroupWidget(title: "select_group".tr)),
              ]),



              subjectController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    int? categoryId = Get.find<QuestionCategoryController>().selectedQuestionCategoryItem?.id;
                    int? classId = Get.find<QuestionBankClassController>().selectedClassItem?.id;
                    int? groupId = Get.find<QuestionBankGroupController>().selectedGroupItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else if(categoryId == null){
                      showCustomSnackBar("select_category".tr);
                    }
                    else if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }

                    else{
                      Get.back();
                      QuestionBankSubjectBody body = QuestionBankSubjectBody(
                          categoryId: categoryId, name: name, classId: classId, groupId: groupId);
                      if(update){
                        subjectController.editQuestionBankSubject(body,  widget.item!.id!);
                      }else{
                        subjectController.createQuestionBankSubject(body).then((val){
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
