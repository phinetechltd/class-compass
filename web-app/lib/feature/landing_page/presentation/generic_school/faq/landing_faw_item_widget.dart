import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/domain/models/faq_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class LandingFaqItemWidget extends StatefulWidget {
  final FaqItem item;
  final bool isExpanded;
  final bool isDesktop;
  final VoidCallback onTap;

  const LandingFaqItemWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.isDesktop,
    required this.onTap,
  });

  @override
  State<LandingFaqItemWidget> createState() => _LandingFaqItemWidgetState();
}

class _LandingFaqItemWidgetState extends State<LandingFaqItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(builder: (settingController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: MouseRegion(cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()..scaleByDouble(_hovered ? 1.02 : 1.0,1,1,1),
              decoration: BoxDecoration(
                color: widget.isExpanded ? settingController.primaryColor : Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: _hovered ? [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8, offset: const Offset(0, 4))
                ]
                    : [
                  BoxShadow(color: Colors.black.withValues(alpha :0.03),
                    blurRadius: 2, offset: const Offset(0, 1))
                ],
                border: Border.all(color: settingController.primaryColor.withValues(alpha: 0.2)),
              ),
              child: Column(children: [
                GestureDetector(onTap: widget.onTap,
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(children: [
                      Expanded(child: Text(widget.item.question ?? '',
                        style: textHeavy.copyWith(color: widget.isExpanded ? Colors.white
                            : Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: widget.isDesktop ? Dimensions.fontSizeLarge
                              : Dimensions.fontSizeExtraLarge))),
                      AnimatedRotation(turns: widget.isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(Icons.keyboard_arrow_down,
                            color: widget.isExpanded ? Colors.white : Colors.grey.shade600)),
                    ]))),

                  AnimatedCrossFade(firstChild: const SizedBox.shrink(),
                    secondChild: Container(width: double.infinity,
                      decoration: BoxDecoration(color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                        border: Border.all(color: settingController.primaryColor)),

                      child: Padding(padding: const EdgeInsets.all(16.0),
                        child: Text(widget.item.answer ?? '', style: textRegular.copyWith()))),

                    crossFadeState: widget.isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
