import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/student_module/student_profile/domain/model/student_profile_model.dart';
import 'package:class_compass/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class StudentProfileInformationWidget extends StatefulWidget {
  const StudentProfileInformationWidget({super.key});

  @override
  State<StudentProfileInformationWidget> createState() => _StudentProfileInformationWidgetState();
}

class _StudentProfileInformationWidgetState extends State<StudentProfileInformationWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final controller = Get.find<ProfileController>();
    await controller.getProfileInfo();
    nameController.text = controller.profileModel?.data?.name ?? "";
    emailController.text = controller.profileModel?.data?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentProfileController>(
      builder: (profileController) {
        StudentProfileModel? profileModel = profileController.profileModel;
        return CustomContainer(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          CustomTextField(title: "name".tr,
          controller: nameController,
          isEnabled: false,
          hintText: "${profileModel?.data?.name}"),

          CustomTextField(title: "email".tr,
            controller: emailController,
              isEnabled: false,
            hintText: "${profileModel?.data?.email}"),
          const SizedBox(height: Dimensions.paddingSizeDefault),
        ],),);
      }
    );
  }
}
