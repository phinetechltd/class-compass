import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/cms_management/feedback/domain/model/feedback_body.dart';
import 'package:class_compass/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:class_compass/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewFeedbackWidget extends StatefulWidget {
  final FeedbackItem? feedbackItem;
  const CreateNewFeedbackWidget({super.key, this.feedbackItem});

  @override
  State<CreateNewFeedbackWidget> createState() => _CreateNewFeedbackWidgetState();
}

class _CreateNewFeedbackWidgetState extends State<CreateNewFeedbackWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    if(widget.feedbackItem != null) {
      nameController.text = widget.feedbackItem?.name??'';
      descriptionController.text = widget.feedbackItem?.description??'';

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(builder: (feedbackController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [

          CustomTextField(title: "name".tr,
              hintText: "name",
          controller: nameController),

          CustomTextField(title: "description".tr, minLines: 3, maxLines: 5, inputType: TextInputType.multiline,
            inputAction: TextInputAction.newline,
              hintText: "description".tr, controller: descriptionController, maxLength: 500),




          const SizedBox(height: Dimensions.paddingSizeLarge),
          feedbackController.loading? const Center(child: CircularProgressIndicator()) :
          CustomButton(
            onTap: () {
              String name = nameController.text.trim();
              String description = descriptionController.text.trim();

              if(name.isEmpty){
                showCustomSnackBar("name_is_empty".tr,);
              }else {
                FeedbackBody body = FeedbackBody(name: name,
                  description: description,
                  method: widget.feedbackItem != null ? "PUT" : "POST",);
                if (widget.feedbackItem != null) {
                  feedbackController.editFeedback(body, widget.feedbackItem!.id!);
                } else {
                  feedbackController.createFeedback(body);
                }
              }
            },
            text: widget.feedbackItem != null?"update".tr : "add".tr,
          ),
        ]);
      }
    );
  }
}