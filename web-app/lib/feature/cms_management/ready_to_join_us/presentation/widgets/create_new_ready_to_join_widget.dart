import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/image_picker_widget.dart';
import 'package:class_compass/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_body.dart';
import 'package:class_compass/feature/cms_management/ready_to_join_us/domain/model/ready_to_join_model.dart';
import 'package:class_compass/feature/cms_management/ready_to_join_us/logic/ready_to_join_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewReadyToJoinWidget extends StatefulWidget {
  final ReadyToJoinItem? readyToJoinItem;
  const CreateNewReadyToJoinWidget({super.key, this.readyToJoinItem});

  @override
  State<CreateNewReadyToJoinWidget> createState() => _CreateNewReadyToJoinWidgetState();
}

class _CreateNewReadyToJoinWidgetState extends State<CreateNewReadyToJoinWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController buttonNameController = TextEditingController();
  TextEditingController buttonLinkController = TextEditingController();

  @override
  void initState() {
    if(widget.readyToJoinItem != null) {
      titleController.text = widget.readyToJoinItem?.title??'';
      descriptionController.text = widget.readyToJoinItem?.description??'';
      buttonNameController.text = widget.readyToJoinItem?.buttonName??'';
      buttonLinkController.text = widget.readyToJoinItem?.buttonLink??'';
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadyToJoinController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [
            CustomTextField(title: "title".tr, hintText: "title".tr, controller: titleController, maxLength: 100),
            CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
                hintText: "description".tr, controller: descriptionController, maxLength: 100),
            CustomTextField(title: "button_name".tr, hintText: "button_name".tr, controller: buttonNameController, maxLength: 100),
            CustomTextField(title: "button_link".tr, hintText: "button_link".tr, controller: buttonLinkController, maxLength: 100),

             ImagePickerWidget(
               pickedFile: controller.thumbnail,
               onImagePicked: ()=> controller.pickImage(),
               imageUrl: "${AppConstants.imageBaseUrl}/ready_to_join/${widget.readyToJoinItem?.icon}",),

            const SizedBox(height: Dimensions.paddingSizeLarge),
            controller.loading? const Center(child: CircularProgressIndicator()) :
            CustomButton(
              onTap: () {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();
                String buttonName = buttonNameController.text.trim();
                String buttonLink = buttonLinkController.text.trim();

                ReadyToJoinBody body = ReadyToJoinBody(
                  title: title,
                  description: description,
                  buttonName: buttonName,
                  buttonLink: buttonLink,
                  method: widget.readyToJoinItem != null? 'PUT' : "POST",

                );
                if(widget.readyToJoinItem != null){
                  controller.editReadyToJoin(body, widget.readyToJoinItem!.id!);
                }else {
                  controller.createReadyToJoin(body);
                }

              },
              text: widget.readyToJoinItem != null?"update".tr : "add".tr,
            ),
          ]),
        );
      }
    );
  }
}