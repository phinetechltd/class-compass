import 'package:flutter/material.dart';
import 'package:class_compass/common/global_widget/global_master_layout_widget.dart';

class SidebarReactiveWrapper extends StatelessWidget {
  final Widget child;
  const SidebarReactiveWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  GlobalSideMenu(child: child));
  }
}
