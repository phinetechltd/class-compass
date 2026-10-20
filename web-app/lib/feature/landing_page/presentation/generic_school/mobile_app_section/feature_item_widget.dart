import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FeatureItemWidget extends StatefulWidget {
  final String? title;
  const FeatureItemWidget({super.key, this.title});

  @override
  State<FeatureItemWidget> createState() => _FeatureItemWidgetState();
}

class _FeatureItemWidgetState extends State<FeatureItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final color = Get.find<FrontendSettingsController>().primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Row(mainAxisAlignment:
      isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center, children: [
        Icon(Icons.check_circle, color: color, size: 18),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        AnimatedContainer(duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(_hovered ? 8 : 0, 0, 0),
          child: Text(widget.title ?? '', style: textBold.copyWith(color: color,
              fontSize: Dimensions.fontSizeLarge)),
        ),
      ],
      ),
    );
  }
}
