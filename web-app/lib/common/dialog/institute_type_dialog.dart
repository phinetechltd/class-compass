import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/enums.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class InstituteMenuDialog extends StatefulWidget {
  const InstituteMenuDialog({super.key});

  @override
  State<InstituteMenuDialog> createState() => _InstituteMenuDialogState();
}

class _InstituteMenuDialogState extends State<InstituteMenuDialog> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(width: 400,
        child: Column(spacing: Dimensions.paddingSizeLarge, children: [
          Container(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                boxShadow: ThemeShadow.getShadow(),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [
                CustomContainer(child: Icon(Icons.school, color: systemPrimaryColor())),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("institute_theme".tr, style: textHeavy.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
                    Text("17 ${"professional_template".tr}", style: textBold.copyWith(color: Theme.of(context).hintColor)),
                  ],)),
                  CustomContainer(onTap: () => Navigator.pop(context),
                      color: Theme.of(context).highlightColor.withValues(alpha: .125), showShadow: false, borderRadius: 123,
                      child: const Icon(Icons.clear, size: 16))
            ],
          )),

            // Search box
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomTextField(hintText: "search_institutes".tr,
                onChanged: (v) => setState(() => search = v.toLowerCase()),
              prefix: Padding(padding: const EdgeInsets.all(8.0),
                child: Image.asset(Images.search, width: 16 ,height: 16, color: Theme.of(context).hintColor),
              ))),

          GetBuilder<LandingPageController>(
            builder: (landingPageController) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomContainer(
                     showShadow: false, verticalPadding: Dimensions.paddingSizeDefault,
                    border: Border.all(color: getRandomColor(), width: .012 ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                      CustomContainer(showShadow: false, color: Theme.of(context).primaryColorDark.withValues(alpha: .125),
                          child: Icon(Icons.school, color: getRandomColor(fullColor: true))),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(landingPageController.selected.label.split(" - ").first,
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        Text(landingPageController.selected.label.split(" - ").length > 1 ? landingPageController.selected.label.split(" - ")[1] : "",
                            style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                      ],)),
                      const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,size: 25,)
                    ],
                    )),
              );
            }
          ),


            // Scrollable list
            Expanded(child: CustomContainer(borderRadius: 0, child: ListView(children: _buildGroupedItems(context)))),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGroupedItems(BuildContext context) {
    final Map<String, List<InstituteEnum>> grouped = {};
    for (var inst in InstituteEnum.values) {
      if (search.isNotEmpty &&
          !inst.label.toLowerCase().contains(search)) {
        continue;
      }

      grouped.putIfAbsent(inst.category, () => []).add(inst);
    }

    List<Widget> widgets = [];
    grouped.forEach((category, institutes) {
      widgets.add(
        Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeLarge, Dimensions.paddingSizeDefault, 0),
          child: Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
              Icon(Icons.arrow_forward_ios_rounded, color: systemPrimaryColor(), size: 12),
              Text(category, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            ],
          )));


      widgets.addAll(institutes.map((e) => _buildInstituteTile(context, e)));
    });

    return widgets;
  }

  Widget _buildInstituteTile(BuildContext context, InstituteEnum inst) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          child: CustomContainer(
              onTap: () => Navigator.pop(context, inst), showShadow: false, verticalPadding: Dimensions.paddingSizeDefault,
              border: Border.all(color: landingPageController.selected == inst? systemPrimaryColor():
              Theme.of(context).primaryColorDark.withValues(alpha: .05), width: landingPageController.selected == inst? 2 : .25),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                CustomContainer(showShadow: false,
                    color: getRandomColor(),
                    child: Icon(inst.icon, color: getRandomColor(fullColor: true))),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(inst.label.split(" - ").first, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  Text(inst.label.split(" - ").length > 1 ? inst.label.split(" - ")[1] : "",
                      style: textSemiBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
                ],)),
              ],
              )),
        );
      }
    );
  }
}



Color getRandomColor({bool fullColor = false}) {
  final colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
  ];

  final random = Random();
  if (fullColor) {
    return colors[random.nextInt(colors.length)];
  }else {
    return colors[random.nextInt(colors.length)].withValues(alpha: .25); // soft background
  }
}
