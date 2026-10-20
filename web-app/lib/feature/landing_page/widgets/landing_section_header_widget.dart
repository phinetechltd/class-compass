import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class LandingSectionHeader extends StatefulWidget {
  final String subtitle;
  final String title;
  final double subtitleFontSize;
  final double titleFontSize;
  final Color? subtitleColor;
  final Color? titleColor;
  final double spacing;
  final bool textAlignCenter;

  const LandingSectionHeader({
    super.key,
    required this.subtitle,
    required this.title,
    this.subtitleFontSize = 20,
    this.titleFontSize = 40,
    this.subtitleColor,
    this.titleColor,
    this.spacing = 8, this.textAlignCenter = true,
  });

  @override
  State<LandingSectionHeader> createState() => _LandingSectionHeaderState();
}

class _LandingSectionHeaderState extends State<LandingSectionHeader> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendSettingsController>(builder: (settingController) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Column(
            crossAxisAlignment: widget.textAlignCenter? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: textMedium.copyWith(
                  fontSize: isDesktop? widget.subtitleFontSize : Dimensions.fontSizeDefault,
                  color: _hovered
                      ? (widget.subtitleColor ?? settingController.primaryColor)
                      : (widget.subtitleColor ??
                      settingController.primaryColor.withValues(alpha: 0.7)),
                ),
                child: Text(widget.subtitle),
              ),

              SizedBox(height: widget.spacing),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                transform: Matrix4.identity()
                  ..scaleByDouble(_hovered ? 1.05 : 1.0, _hovered ? 1.05 : 1.0, 1, 1),

                transformAlignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: textBold.copyWith(
                    fontSize: isDesktop? widget.titleFontSize : Dimensions.fontSizeExtraLarge,
                    color: _hovered
                        ? (widget.titleColor ?? settingController.primaryColor)
                        : (widget.titleColor ??
                        settingController.primaryColor.withValues(alpha: 0.85)),
                  ),
                  child: Text(widget.title),
                ),
              ),

              const SizedBox(height: 6),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 3,
                width: _hovered ? 80 : 60,
                decoration: BoxDecoration(
                  color: settingController.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
