import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/profile/presentation/widgets/password_update_widget.dart';
import 'package:class_compass/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:class_compass/feature/student_module/student_profile/presentation/widgets/student_profile_information_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  void initState() {
    Get.find<StudentProfileController>().getStudentProfileInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "profile".tr,),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StudentProfileInformationWidget(),
              SizedBox(height: Dimensions.paddingSizeDefault),
              PasswordUpdateWidget(),
            SizedBox(height: Dimensions.paddingSizeDefault,),

            ],
          ),
        ),)
      ],),
    );
  }
}
