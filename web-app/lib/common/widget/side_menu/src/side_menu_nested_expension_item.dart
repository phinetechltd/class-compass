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
  /// Every menu entry gets an icon that matches its label. Using Material
  /// rounded icons keeps the sidebar consistent and avoids reusing the generic
  /// dashboard glyph for unrelated sections.
  static const Map<String, IconData> _menuIcons = {
    'dashboard': Icons.space_dashboard_rounded,
    'branch': Icons.account_tree_rounded,
    'student_information': Icons.groups_rounded,
    'student_attendance': Icons.fact_check_rounded,
    'academic_configuration': Icons.tune_rounded,
    'staff_information': Icons.badge_rounded,
    'payroll_management': Icons.payments_rounded,
    'fees_management': Icons.request_quote_rounded,
    'account_management': Icons.account_balance_rounded,
    'accounting_reports_management': Icons.assessment_rounded,
    'routine_management': Icons.calendar_month_rounded,
    'library_management': Icons.local_library_rounded,
    'exm_management': Icons.assignment_rounded,
    'layout_and_certificate': Icons.workspace_premium_rounded,
    'sms_management': Icons.sms_rounded,
    'administrator': Icons.admin_panel_settings_rounded,
    'question_bank': Icons.quiz_rounded,
    'course_management': Icons.menu_book_rounded,
    'fees_reports_management': Icons.insert_chart_rounded,
    'master_configuration': Icons.settings_suggest_rounded,
    'zoom_meeting': Icons.videocam_rounded,
    'cms_management': Icons.language_rounded,
    'hostel_management': Icons.hotel_rounded,
    'transportation_management': Icons.directions_bus_rounded,
    'AI': Icons.auto_awesome_rounded,
    'inventory_management': Icons.inventory_2_rounded,
    'supplier_management': Icons.local_shipping_rounded,
    'reports_management': Icons.bar_chart_rounded,
    'routine': Icons.calendar_month_rounded,
    'fees': Icons.payments_rounded,
    'pay_school_fees': Icons.phone_android_rounded,
    'library': Icons.local_library_rounded,
    'assignment': Icons.assignment_rounded,
    'behavior': Icons.psychology_rounded,
    'notice': Icons.campaign_rounded,
    'event': Icons.event_rounded,
    'exams': Icons.quiz_rounded,
    'profile': Icons.person_rounded,
  };

  Widget buildIcon(String iconPath, Color? iconColor) {
    final Color resolvedColor = iconColor ?? Theme.of(Get.context!).hintColor;
    final IconData? matched = _menuIcons[keyValue];

    if (matched != null) {
      return Icon(matched, size: 18, color: resolvedColor);
    }

    final isSvg = iconPath.toLowerCase().endsWith('.svg');

    return isSvg ? SvgPicture.asset(iconPath, height: 18,
      colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
    ) : Image.asset(iconPath, height: 18, color: resolvedColor);
  }

}
