import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/remark_config/domain/model/re_mark_config_body.dart';
import 'package:class_compass/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewReMarkConfigDialog extends StatefulWidget {
  final RemarkConfigItem? remarkConfigItem;
  const CreateNewReMarkConfigDialog({super.key, this.remarkConfigItem});

  @override
  State<CreateNewReMarkConfigDialog> createState() => _CreateNewReMarkConfigDialogState();
}

class _CreateNewReMarkConfigDialogState extends State<CreateNewReMarkConfigDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.remarkConfigItem != null){
      update = true;
      nameController.text = widget.remarkConfigItem?.remarkTitle??'';
      descriptionController.text = widget.remarkConfigItem?.remarks??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReMarkConfigController>(builder: (remarkConfigController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [

          CustomTextField(title: "title".tr,
            controller: nameController,
            hintText: "title".tr,),

          CustomTextField(title: "remark".tr,
            controller: descriptionController,
            hintText: "remark".tr,),


          remarkConfigController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Center(child: CircularProgressIndicator())):

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomButton(onTap: (){
              String name = nameController.text.trim();
              String description = descriptionController.text.trim();
              if(name.isEmpty){
                showCustomSnackBar("name_is_empty");
              }else if(description.isEmpty){
                showCustomSnackBar("priority_is_empty");
              }else{
                ReMarkConfigBody body = ReMarkConfigBody(
                  remarkTitle: name,
                  remarks: description,
                  method: update? "PUT":"POST",
                );
                if(update){
                  remarkConfigController.updateReMarkConfig(body, widget.remarkConfigItem!.id!);
                }else{
                  remarkConfigController.createNewReConfig(body);
                }

              }
            }, text: update? "update".tr : "save".tr))
        ],);
      }
    );
  }
}
