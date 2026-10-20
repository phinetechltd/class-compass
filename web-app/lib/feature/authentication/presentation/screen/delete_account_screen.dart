import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/helper/email_checker.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
   TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).cardColor,
      body: Center(
        child: SizedBox(width: 800,
          child: CustomContainer(
            child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeDefault, children: [
              Image.asset(Images.deleteIcon, height: 100),
              Text("account_deletion_message".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
              CustomTextField(controller: emailController, hintText: "enter_valid_email".tr),
              Align(alignment: Alignment.centerRight,
                  child: SizedBox(width: 150,
                    child: CustomButton(onTap: (){
                      String email = emailController.text.trim();
                      if(email.isEmpty){
                        showCustomSnackBar("email_is_empty".tr);
                      }else if(EmailChecker.isNotValid(email)){
                        showCustomSnackBar("enter_valid_email".tr);
                      }else{
                        Get.dialog(
                            Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(width: 400,
                                child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                                    const CustomImage(image: Images.sms, width: 50, localAsset: true),
                                    Text("please_check_your_email_you_will_get_a_link_to_delete_your_account".tr,
                                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                    const SizedBox(height: Dimensions.paddingSizeDefault),
                                    Align(alignment: Alignment.centerRight,
                                        child: SizedBox(width: 120,
                                          child: CustomButton(onTap: (){
                                            Get.back();
                                            Get.toNamed(RouteHelper.getInitialRoute());
                                          }, text: "okay".tr),
                                        )),
                                  ],),
                                ),
                              ),
                            )
                        );
                      }
                    }, text: "submit_request".tr),
                  )),

            ],
            ),
          ),
        ),
      ),
    );
  }
}
