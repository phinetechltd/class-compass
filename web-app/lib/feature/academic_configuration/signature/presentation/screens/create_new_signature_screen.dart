import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/pick_image_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_pick_image_widget.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewSignatureScreen extends StatefulWidget {
  final SignatureItem? signatureItem;
  const CreateNewSignatureScreen({super.key, this.signatureItem});

  @override
  State<CreateNewSignatureScreen> createState() => _CreateNewSignatureScreenState();
}

class _CreateNewSignatureScreenState extends State<CreateNewSignatureScreen> {

  TextEditingController placeAtController = TextEditingController();
  TextEditingController titleController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.signatureItem != null){
      update = true;
      placeAtController.text = widget.signatureItem?.placeAt??'';
      titleController.text = widget.signatureItem?.title??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignatureController>(builder: (signatureController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomTitle(title: "add_new_signature")),



          CustomTextField(title: "place_at".tr,
            controller: placeAtController,
            hintText: "place_at".tr,),

          CustomTextField(title: "title".tr,
            controller: titleController,
            hintText: "title".tr,),
          const SizedBox(height: Dimensions.paddingSizeSmall,),


           CustomPickImageWidget(
            imageUrl: "${AppConstants.imageBaseUrl}/signatures/${widget.signatureItem?.image}",
          ),


          signatureController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Center(child: CircularProgressIndicator())):

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomButton(onTap: (){


              String title = titleController.text.trim();
              String placeAt = placeAtController.text.trim();

              if(title.isEmpty){
                showCustomSnackBar("priority_is_empty".tr);
              }
              else if(placeAt.isEmpty){
                showCustomSnackBar("place_at_is_empty".tr);
              }
              else if(Get.find<PickImageController>().thumbnail == null){
                showCustomSnackBar("signature_is_empty".tr);
              }
              else{
                if(update){
                  signatureController.updateSignature(placeAt, title, widget.signatureItem!.id!);
                }else{
                  signatureController.createNewSignature(placeAt, title,);
                }

              }
            }, text:  "confirm".tr))
        ],);
      }
    );
  }
}
