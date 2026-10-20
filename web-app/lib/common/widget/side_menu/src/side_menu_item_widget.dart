import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/side_menu/src/side_bar_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/util/styles.dart';

class SideMenuChildItemWidget extends StatelessWidget {
  final String title;
  final String keyValue;
  final VoidCallback onTap;
  final String? icon;

  const SideMenuChildItemWidget({super.key, required this.title, required this.keyValue, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SidebarController>(builder: (controller) {
      final primaryColor = Get.find<SystemSettingsController>().sidebarTextColor;
      final textColor = Get.find<SystemSettingsController>().sidebarTextColor;
      final bool selected = controller.isActive(keyValue);


      return InkWell(onTap: () {
          controller.onNestedTap(keyValue);
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(children: [
              Icon(Icons.arrow_right_alt, color: selected ? primaryColor : textColor,),
              Expanded(child: Text(title,
                style: textRegular.copyWith(color:selected ? primaryColor : textColor,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
