import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class NewsLetterWidget extends StatefulWidget {
  const NewsLetterWidget({super.key});

  @override
  State<NewsLetterWidget> createState() => _NewsLetterWidgetState();
}

class _NewsLetterWidgetState extends State<NewsLetterWidget> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("stay_updated".tr, style: textBold.copyWith(fontSize: 20  ),),
            Text("sign_up_newsletter".tr, style: textRegular.copyWith(fontSize: 16),),
            const SizedBox(height: 30),
            TextFormField(controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "your_email".tr,
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF1E294A), // Dark blue background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF2A3557), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white70, width: 1.5),
                ),
                suffixIcon: SizedBox(width: 100,
                   child: CustomButton(onTap: (){
                    String email = emailController.text.trim();
                    if(email.isEmpty){
                      showCustomSnackBar("enter_email_address".tr);
                    }else if(!GetUtils.isEmail(email)){
                      showCustomSnackBar("enter_valid_email_address".tr);
                    }else{
                      Get.find<LandingPageController>().newsLetter(email);
                    }
                  }, text: "subscribe".tr),
                ),
              ),
            ),
          ],
          ),
        );
      }
    );
  }
}
