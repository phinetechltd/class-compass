import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/side_menu/src/side_bar_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SideMenuNestedItem extends StatelessWidget {
  final String keyValue;
  final String title;
  final String icon;
  final List<Widget>? children;
  final bool parent;
  final VoidCallback? onTap;
  final String? sectionTitle;

  const SideMenuNestedItem({
    super.key,
    required this.keyValue,
    required this.title,
    required this.icon,
    this.children,
    this.parent = false,
    this.onTap,
    this.sectionTitle,
  });

  bool get hasChildren => children != null && children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        final String? roleType = Get.find<ProfileController>().profileModel?.data?.role;
        Color color = roleType == AppConstants.sassAdmin
            ? Colors.white
            : systemSettingsController.sidebarTextColor;
        return GetBuilder<SidebarController>(builder: (controller) {
          final bool isExpanded = controller.isExpanded(keyValue);
          final bool isActive = controller.isActive(keyValue);

          void handleTap() {
            if (parent) {
              controller.onTopLevelTap(keyValue, hasChildren: hasChildren);
              if (!hasChildren) onTap?.call();
            } else {
              controller.onNestedTap(keyValue, hasChildren: hasChildren);
              if (!hasChildren) onTap?.call();
            }
          }

          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              if (sectionTitle != null && sectionTitle!.isNotEmpty)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Padding(padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      child: Text(sectionTitle!.toUpperCase(), style: textRegular.copyWith(
                           color: color.withValues(alpha: .5), letterSpacing: 0.5))),
                  ],
                ),

              /// --- Parent/Nested Menu Header ---
              InkWell(onTap: handleTap,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Container(padding: EdgeInsets.fromLTRB(parent ? 12 : 0, 15, 12, 15),
                    decoration: BoxDecoration(color: ((isExpanded || isActive) && parent)
                          ? systemPrimaryColor() : Colors.transparent,
                      borderRadius: BorderRadius.circular(40)),
                    child: Row(children: [
                      (parent) ? buildIcon(icon, ((isExpanded || isActive) && parent) ? Colors.white : color)

                          : Icon(Icons.arrow_right_alt, color: ((isExpanded || isActive) && !parent)
                          ? systemPrimaryColor() : Theme.of(context).dividerColor),
                        const SizedBox(width: 8),
                        Expanded(child: Text(title, style: textRegular.copyWith(color: ((isExpanded || isActive) && parent)
                                  ? Colors.white
                                  : ((isExpanded || isActive) && !parent)
                                  ? systemPrimaryColor()
                                  : color, fontWeight: ((isExpanded || isActive) && parent)
                                  ? FontWeight.bold
                                  : FontWeight.normal))),
                        if (hasChildren)
                          AnimatedRotation(turns: isExpanded ? 0.25 : 0,
                            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,
                            child: Icon(Icons.keyboard_arrow_right, size: 18,
                              color: ((isExpanded || isActive) && parent) ? Colors.white : color)),
                      ],
                    ),
                  ),
                ),
              ),

              /// --- CHILDREN WITH CONNECTING VERTICAL LINE ---
              AnimatedSwitcher(duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic, switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slideAnimation = Tween<Offset>(
                    begin: const Offset(0, -0.05), end: Offset.zero,).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
                  return FadeTransition(opacity: animation,
                    child: SlideTransition(position: slideAnimation, child: child));
                },
                child: (hasChildren && isExpanded) ? Padding(key: ValueKey("${keyValue}_expanded"),
                  padding: const EdgeInsets.only(left: 26, top: 5),
                  child: Stack(children: [

                    Positioned(left: 9, top: 0, bottom: 0,
                        child: Container(width: 1.4, color: Theme.of(context).dividerColor)),

                    Padding(padding: const EdgeInsets.only(left: 20),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children!)),
                    ],
                  ),
                ) : const SizedBox.shrink(key: ValueKey("collapsed")),
              ),
            ],
          );
        });
      }
    );
  }
  Widget buildIcon(String iconPath, Color? iconColor) {
    final isSvg = iconPath.toLowerCase().endsWith('.svg');

    return isSvg ? SvgPicture.asset(iconPath, height: 16,
      colorFilter: ColorFilter.mode(iconColor??Theme.of(Get.context!).hintColor, BlendMode.srcIn),
    ) : Image.asset(iconPath, height: 16, color: iconColor);
  }

}
