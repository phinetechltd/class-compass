import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/profile/presentation/widgets/password_update_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "change_pin".tr),
      body: const PasswordUpdateWidget(),
    );
  }
}
