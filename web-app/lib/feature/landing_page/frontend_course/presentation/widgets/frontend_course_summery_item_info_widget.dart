import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class FrontendCourseSummeryInfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String count;
  const FrontendCourseSummeryInfoWidget({super.key, required this.icon, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: Dimensions.paddingSizeSmall, children: [
      Row(spacing: Dimensions.paddingSizeSmall, children: [
        CustomImage(width: 20, localAsset: true, image: icon),
        Expanded(child: Text(title, style: textRegular.copyWith())),
        Text(count, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall))
      ]),
      const CustomDivider()
    ],
    );
  }
}
