import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/image_picker_widget.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/widgets/select_signature_item_widget.dart';
import 'package:class_compass/feature/exam_management/marksheet/controller/markaheet_controller.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/model/marksheet_config_body.dart';
import 'package:class_compass/feature/exam_management/marksheet/widgets/sample_marksheet_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AddNewMarkSheetConfigWidget extends StatefulWidget {
  const AddNewMarkSheetConfigWidget({super.key});

  @override
  State<AddNewMarkSheetConfigWidget> createState() => _AddNewMarkSheetConfigWidgetState();
}

class _AddNewMarkSheetConfigWidgetState extends State<AddNewMarkSheetConfigWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkSheetController>(initState: (value){
      Get.find<MarkSheetController>().getMarkSheetConfigList(1);
      },
        builder: (controller) {
      bool isDesktop = ResponsiveHelper.isDesktop(context);
      return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Row(spacing: Dimensions.paddingSizeDefault,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: isDesktop?200: Get.width,
              child: SingleChildScrollView(
                child: Column(spacing: Dimensions.paddingSizeDefault, children: [
                  CustomTextField(controller: nameController,
                    title: "title".tr, hintText: "title".tr),

                   SelectCustomerWithSearchWidget(title: "select_principal_sign".tr),
                   SelectCustomerWithSearchWidget(title: "select_teacher_sign".tr,
                   isTeacher: true),
                  LogoItem(
                    title: "header_logo".tr,
                    pickedFile: controller.headerLogo,
                    imageUrl: "",
                    onPick: () => controller.pickImage("header"),
                    ),

                  LogoItem(
                    title: "border_image".tr,
                    pickedFile: controller.borderDesign,
                    imageUrl:"",
                    logoSize: "border_size_will_be_a4_size".tr,
                    onPick: () => controller.pickImage("border"),
                    ),


                  LogoItem(
                    title: "watermark".tr,
                    pickedFile: controller.watermark,
                    imageUrl: "",
                    onPick: () => controller.pickImage("watermark"),
                    ),

                  LogoItem(
                    title: "institute_stamp".tr,
                    pickedFile: controller.stampImage,
                    imageUrl: "",
                    onPick: () => controller.pickImage("stampImage"),
                  ),
                  controller.isLoading? const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                    String? name = nameController.text.trim();
                    int? principalSignatureId = Get.find<SignatureController>().selectedSignatureItem?.id;
                    int? teacherSignatureId = Get.find<SignatureController>().selectedTeacherSignatureItem?.id;

                    if(name.isEmpty){
                      showCustomSnackBar("title_is_empty".tr);
                    }else if(principalSignatureId == null){
                      showCustomSnackBar("select_principal_sign".tr);
                    }else if(teacherSignatureId == null){
                      showCustomSnackBar("select_teacher_sign".tr);
                    }else if(controller.headerLogo == null){
                      showCustomSnackBar("header_logo_is_empty".tr);
                    }else if(controller.borderDesign == null){
                      showCustomSnackBar("border_image_is_empty".tr);
                    }else if(controller.watermark == null){
                      showCustomSnackBar("watermark_is_empty".tr);
                    }else if(controller.stampImage == null){
                      showCustomSnackBar("institute_stamp_is_empty".tr);
                    }else{
                      MarksheetConfigBody body = MarksheetConfigBody(
                          name: name,
                          signatureId: principalSignatureId,
                          teacherSignatureId: teacherSignatureId,
                          status: 1
                      );
                      controller.createNewMarkSheetConfig(body);
                    }
                  }, text: "confirm".tr)
                ]),
              ),
            ),
            if(isDesktop)
            const SizedBox(width: 600,child: SampleMarksheetWidget())
          ],
        ),
      );
    });
  }
}

class LogoItem extends StatelessWidget {
  final String title;
  final String? logoSize;
  final dynamic pickedFile;
  final String imageUrl;
  final VoidCallback onPick;

  const LogoItem({
    super.key,
    required this.title,
    required this.pickedFile,
    required this.imageUrl,
    required this.onPick, this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(verticalPadding: Dimensions.paddingSizeLarge, showShadow: false,
      child: Column(spacing: Dimensions.paddingSizeDefault, children: [
        Text(title, style: textRegular.copyWith()),
        ImagePickerWidget(pickedFile: pickedFile, imageUrl: imageUrl,
            onImagePicked: onPick),

        Text(logoSize?? "logo_size".tr,
            style: textRegular.copyWith(color: Theme.of(context).hintColor,
              fontSize: Dimensions.fontSizeExtraSmall),
          textAlign: TextAlign.center),

      ]),
    );
  }
}

class LogoSectionHeading extends StatelessWidget {
  final String title;
  final String subTitle;

  const LogoSectionHeading({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 4, children: [
      Text(title, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
      Text(subTitle, style: textRegular.copyWith(color: Theme.of(context).hintColor),
          textAlign: TextAlign.center),
    ]);
  }
}
