import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/domain/models/teacher_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';


class FrontendTeacherCardWidget extends StatefulWidget {
  final TeacherItem? item;
  const FrontendTeacherCardWidget({super.key, this.item});

  @override
  State<FrontendTeacherCardWidget> createState() => _FrontendTeacherCardWidgetState();
}

class _FrontendTeacherCardWidgetState extends State<FrontendTeacherCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(builder: (settingController) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transformAlignment: Alignment.center,
          transform: _hovered ? (Matrix4.identity()..translateByDouble(0, -8, 0, 1))
              : Matrix4.identity(),
          child: Padding(padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
                CustomContainer(width: 220,
                  horizontalPadding: 10, verticalPadding: 10,
                  borderRadius: 8, showShadow: _hovered,
                  border: Border.all(width: 1, color: _hovered
                        ? settingController.primaryColor
                        : settingController.primaryColor.withValues(alpha: 0.12)),

                  child: Column(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(6),
                        child: AnimatedScale(scale: _hovered ? 1.05 : 1,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          child: CustomImage(width: 200, height: 200, image:
                            "${AppConstants.baseUrl}/storage/users/${widget.item?.user?.image ?? ''}",
                          ))),

                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color: _hovered ? settingController.primaryColor
                              : Theme.of(context).textTheme.bodyLarge?.color),

                        child: Text(widget.item?.name ?? '', maxLines: 1,
                          overflow: TextOverflow.ellipsis)),

                      const SizedBox(height: 4),
                      Text(widget.item?.designation ?? '',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,)),

                    ],
                  ),
                ),


                AnimatedPositioned(duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut, left: _hovered ? 20 : -50, top: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _hovered ? 1 : 0,
                    child: Column(children: [
                        _socialIcon(FontAwesomeIcons.facebook, "", const Color(0xFF3b5998)),
                        const SizedBox(height: 8),
                        _socialIcon(FontAwesomeIcons.linkedin, "", const Color(0xFF0e76a8)),
                        const SizedBox(height: 8),
                        _socialIcon(FontAwesomeIcons.twitter, "", const Color(0xFF00acee)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _socialIcon(FaIconData icon, String? url, Color color) {
    return MouseRegion(cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: () {
          if (url != null && url.isNotEmpty) {
            launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
          }
        },
        child: Container(padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: FaIcon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
