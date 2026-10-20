

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/sent_new_sms_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class SentNewSmsScreen extends StatefulWidget {
  const SentNewSmsScreen({super.key});

  @override
  State<SentNewSmsScreen> createState() => _SentNewSmsScreenState();
}

class _SentNewSmsScreenState extends State<SentNewSmsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:  "sent_sms".tr,),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SentNewSmsWidget()),)
      ],),
    );
  }
}
