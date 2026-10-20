import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/select_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankGroupWidget extends StatefulWidget {
  final QuestionBankGroupItem? item;
  const CreateNewQuestionBankGroupWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankGroupWidget> createState() => _CreateNewQuestionBankGroupWidgetState();
}

class _CreateNewQuestionBankGroupWidgetState extends State<CreateNewQuestionBankGroupWidget> {
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
    return GetBuilder<QuestionBankGroupController>(
        builder: (groupController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_group".tr : "add_new_group".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),


              const QuestionBankSelectClassWidget(),
              CustomTextField(title: "group_name".tr,
                controller: nameController,
                hintText: "enter_group_name".tr,),



              groupController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    int? classId = Get.find<QuestionBankClassController>().selectedClassItem?.id;
                    String name = nameController.text.trim();
                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                    else if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        groupController.editQuestionBankGroup(classId.toString(), name,  widget.item!.id!);
                      }else{
                        groupController.createQuestionBankGroup(classId.toString(), name);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
