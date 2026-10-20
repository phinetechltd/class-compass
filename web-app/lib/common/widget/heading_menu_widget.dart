import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class HeadingMenu extends StatelessWidget {
  final List<String> headings;
  final List<int>? flex;
  final bool showActionOption;

  const HeadingMenu({super.key, required this.headings, this.flex, this.showActionOption = true});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Container(padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(color: systemPrimaryColor().withValues(alpha: .2),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusSmall))),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(spacing:  Dimensions.paddingSizeDefault, children: [
               SizedBox(width: 40, child: Text("SL.",
                   style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                       color: systemPrimaryColor()))),

              ...List.generate(headings.length, (index) {
                final textWidget = Text(headings[index].tr,
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: systemPrimaryColor()));
                if (flex != null && flex!.length > index) {
                  return Expanded(flex: flex![index], child: textWidget);
                } else if(headings[index] == 'file' ||headings[index] == 'image' || headings[index] == 'status' ){
                  return textWidget;
                } else {
                  return Expanded(child: textWidget);
                }
              }),
            if(showActionOption)
            Text("⚙️", style: textRegular.copyWith(color: systemPrimaryColor()))
            ],
          ),
        ),
      ),
    );
  }
}
