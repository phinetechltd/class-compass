import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/image_dialog.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/screens/create_new_signature_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SignatureItemWidget extends StatelessWidget {
  final SignatureItem? signatureItem;
  final int index;
  const SignatureItemWidget({super.key, this.signatureItem, required this.index});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "${AppConstants.imageBaseUrl}/signatures/${signatureItem?.image??''}";
    return Padding(padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
          InkWell(onTap: ()=> Get.dialog(ImageDialog(
              imageUrl: imageUrl)),
              child: CustomImage(width: 40, image: imageUrl,)),
          Expanded(child: Text("${signatureItem?.title}",
            style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
          Expanded(child: Text(" ${signatureItem?.placeAt??''}",
            style: textRegular.copyWith(),)),
          EditDeletePopupMenu(onEdit: (){
            Get.dialog(CreateNewSignatureScreen(signatureItem: signatureItem));
          },
            onDelete: (){
              Get.find<SignatureController>().deleteSignature(signatureItem!.id!);
          },)
        ],
      ): CustomContainer(child: Row(
        children: [
          InkWell(onTap: ()=> Get.dialog(ImageDialog(imageUrl: imageUrl)),
              child: CustomImage(height: 50, image: imageUrl)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${signatureItem?.title}", style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text("${"place_at".tr} : ${signatureItem?.placeAt??''}",
              style: textRegular.copyWith(),),
          ]),
          ),
          EditDeletePopupMenu(onEdit: (){
            Get.dialog(CustomDialogWidget(title: "signature".tr,
                child: CreateNewSignatureScreen(signatureItem: signatureItem)));
          },
            onDelete: (){
            Get.find<SignatureController>().deleteSignature(signatureItem!.id!);
            },)
        ],
      )),
    );
  }
}