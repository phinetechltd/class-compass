import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/feature/question_bank/question_category/logic/question_category_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionCategoryWidget extends StatefulWidget {
  final QuestionCategoryItem? questionCategoryItem;
  const CreateNewQuestionCategoryWidget({super.key, this.questionCategoryItem});

  @override
  State<CreateNewQuestionCategoryWidget> createState() => _CreateNewQuestionCategoryWidgetState();
}

class _CreateNewQuestionCategoryWidgetState extends State<CreateNewQuestionCategoryWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  bool update = false;
  @override
  void initState() {
    if(widget.questionCategoryItem != null){
      update = true;
      nameController.text = widget.questionCategoryItem?.name??'';
      priorityController.text = widget.questionCategoryItem?.priority.toString()??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionCategoryController>(
        builder: (questionCategoryController) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [

              CustomTextField(title: "name".tr,
                controller: nameController,
                hintText: "enter_name".tr,),

              CustomTextField(title: "priority".tr,
                controller: priorityController,
                inputType: TextInputType.number,
                inputFormatters: [AppConstants.numberFormat],
                hintText: "priority".tr,),


              questionCategoryController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Align(alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: Align(alignment: Alignment.centerRight,
                        child: CustomButton(onTap: (){
                          String name = nameController.text.trim();
                          String priority = priorityController.text.trim();


                          if(name.isEmpty){
                            showCustomSnackBar("name_is_empty".tr);
                          }

                          else if(priority.isEmpty){
                            showCustomSnackBar("priority_is_empty".tr);
                          }
                          else{
                            if(update){
                              questionCategoryController.editQuestionCategory(name,priority, widget.questionCategoryItem!.id!);
                            }else{
                              questionCategoryController.createQuestionCategory(name, priority);
                            }

                          }
                        }, text: update? "update".tr : "save".tr),
                      ),
                    ),
                  ))
            ],),
          );
        }
    );
  }
}
