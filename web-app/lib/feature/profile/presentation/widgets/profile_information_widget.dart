import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/profile/domain/model/profile_model.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class ProfileInformationWidget extends StatefulWidget {
  const ProfileInformationWidget({super.key});

  @override
  State<ProfileInformationWidget> createState() => _ProfileInformationWidgetState();
}

class _ProfileInformationWidgetState extends State<ProfileInformationWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = Get.find<ProfileController>().profileModel?.data?.name ?? "";
    emailController.text = Get.find<ProfileController>().profileModel?.data?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;
        return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomTitle(title: "profile_information"),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          const CustomSubTitle(title: "profile_info_sub_title"),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          CustomTextField(title: "name".tr,
          controller: nameController,
          hintText: "${profileModel?.data?.name}"),

          CustomTextField(title: "email".tr,
            controller: emailController,
            hintText: "${profileModel?.data?.email}"),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          if(!AppConstants.demo)
          Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 100,
                  child: profileController.isLoading?const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                if(name.isEmpty){
                  showCustomSnackBar("name_is_empty".tr);
                }else if(!email.isEmail){
                  showCustomSnackBar("email_is_invalid".tr);
                }else{
                  profileController.updateProfile(name, email);
                }

              }, text: "submit".tr)))
        ],),);
      }
    );
  }
}
