import 'package:flutter/material.dart';
import 'package:class_compass/common/global_widget/side_bar_reactive_wrapper.dart';
import 'package:class_compass/common/widget/web_app_bar.dart';
import 'package:class_compass/helper/responsive_helper.dart';

class CustomWebScrollView extends StatelessWidget {
  final ScrollController? controller;
  final List<Widget> slivers;
  final bool showAppBar;

  const CustomWebScrollView({super.key, this.controller, required this.slivers, this.showAppBar = true,});

  @override
  Widget build(BuildContext context) {
    return SidebarReactiveWrapper(
      child: CustomScrollView(controller: controller, slivers: [
          if (showAppBar && ResponsiveHelper.isDesktop(context))
            const SliverAppBar(automaticallyImplyLeading: false, title: WebAppBar(), titleSpacing: 0, pinned: true,),
          ...slivers,
        ],
      ),
    );
  }
}