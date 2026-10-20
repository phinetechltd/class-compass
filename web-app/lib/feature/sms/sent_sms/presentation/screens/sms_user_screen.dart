import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/user_list_for_sms_widget.dart';

class SmsUserScreen extends StatefulWidget {
  const SmsUserScreen({super.key});

  @override
  State<SmsUserScreen> createState() => _SmsUserScreenState();
}

class _SmsUserScreenState extends State<SmsUserScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "sms_user_list".tr),

      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: UserListForSmsWidget(scrollController: scrollController),)
      ],),

    );
  }
}
