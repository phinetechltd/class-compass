import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:class_compass/feature/sms/sms_template/domain/models/sms_template_model.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewSmsTemplateScreen extends StatefulWidget {
  final SmsTemplateItem? smsTemplateItem;
  const CreateNewSmsTemplateScreen({super.key, this.smsTemplateItem});

  @override
  State<CreateNewSmsTemplateScreen> createState() => _CreateNewSmsTemplateScreenState();
}

class _CreateNewSmsTemplateScreenState extends State<CreateNewSmsTemplateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.smsTemplateItem != null){
      update = true;
      nameController.text = widget.smsTemplateItem?.name??'';
      descriptionController.text = widget.smsTemplateItem?.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsTemplateController>(builder: (smsTemplateController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [

          CustomTextField(title: "name".tr,
            controller: nameController,
            hintText: "enter_name".tr,),

          CustomTextField(title: "description".tr,
            controller: descriptionController,
            hintText: "description".tr,),


          smsTemplateController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
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
                if(update){
                  smsTemplateController.updateSmsTemplate(name, description, widget.smsTemplateItem!.id!);
                }else{
                  smsTemplateController.createNewSmsTemplate(name, description);
                }

              }
            }, text: update? "update".tr : "save".tr))
        ],);
      }
    );
  }
}
