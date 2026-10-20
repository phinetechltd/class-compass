import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/presentation/widgets/add_new_hostel_member_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewHostelMemberScreen extends StatefulWidget {
  final int? memberId;
  const AddNewHostelMemberScreen({super.key, this.memberId});

  @override
  State<AddNewHostelMemberScreen> createState() => _AddNewHostelMemberScreenState();
}

class _AddNewHostelMemberScreenState extends State<AddNewHostelMemberScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "hostel_members".tr),

      body:  CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AddNewHostelMemberWidget(memberId: widget.memberId,)))
      ]),


    );
  }
}
