import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CourseSummeryInfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String count;
  final bool showDivider;
  const CourseSummeryInfoWidget({super.key, required this.icon, required this.title, required this.count, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(spacing: Dimensions.paddingSizeDefault, children: [
        Row(spacing: Dimensions.paddingSizeSmall, children: [
          CustomImage(width: 20, localAsset: true, image: icon),
          Expanded(child: Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge))),
          Text(count, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall))
        ]),
        if(showDivider)
        const CustomDivider()
      ],
      ),
    );
  }
}
