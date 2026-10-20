import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/image_picker_widget.dart';
import 'package:class_compass/feature/cms_management/about_us/domain/model/about_us_body.dart';
import 'package:class_compass/feature/cms_management/about_us/logic/about_us_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';


class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Get.find<AboutUsController>().getAboutUs(1);
    var aboutUs = Get.find<AboutUsController>().aboutUsModel?.data?.data?[0];
    if (aboutUs != null) {
      setState(() {
        titleController.text = aboutUs.title ?? '';
        descriptionController.text = aboutUs.description ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(builder: (aboutUsController) {
        String imageUrl = (aboutUsController.aboutUsModel?.data?.data != null && aboutUsController.aboutUsModel?.data?.data?.isNotEmpty == true)?
            "${AppConstants.imageBaseUrl}/about_us/${aboutUsController.aboutUsModel?.data?.data?.first.image}":"";
        return Column(spacing: Dimensions.paddingSizeSmall, children: [
            CustomTextField(
              title: "title".tr,
              hintText: "title".tr,
              controller: titleController,
              maxLength: 100,
            ),

            CustomTextField(
              maxLines: 7,
              minLines: 5,
              inputType: TextInputType.multiline,
              title: "description".tr,
              hintText: "description".tr,
              controller: descriptionController,
              inputAction: TextInputAction.newline,
              maxLength: 500,
            ),

            ImagePickerWidget(onImagePicked: () => aboutUsController.pickImage(),
            pickedFile: aboutUsController.thumbnail,
            imageUrl: imageUrl,),

            const SizedBox(height: Dimensions.paddingSizeLarge),
            aboutUsController.isLoading? const Center(child: CircularProgressIndicator()):
            CustomButton(
              onTap: () {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();
                AboutUsBody body = AboutUsBody(
                  title: title,
                  description: description,
                  method: aboutUsController.aboutUsModel?.data?.data?.isNotEmpty == true? 'PUT' : "post",

                );
                if(aboutUsController.aboutUsModel?.data?.data?.isNotEmpty == true){
                  aboutUsController.editAboutUs(body, aboutUsController.aboutUsModel?.data?.data?.first.id??0);
                }else{
                  aboutUsController.createAboutUs(body);
                }
              },
              text: "update".tr,
            ),
          ],
        );
      },
    );
  }
}