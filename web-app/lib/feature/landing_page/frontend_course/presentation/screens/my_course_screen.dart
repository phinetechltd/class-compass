
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/not_login_widget.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/my_course_list_widget.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "courses".tr),
        body: GetBuilder<AuthenticationController>(
          builder: (authenticationController) {
            bool isLoggedIn = authenticationController.isLoggedIn();
            return isLoggedIn?
            CustomWebScrollView(controller: scrollController, slivers: [
                SliverToBoxAdapter(child: MyCourseListWidget(scrollController: scrollController),)
              ],)
            :const NotLoginWidget();
          }
        ),

    );
  }
}



