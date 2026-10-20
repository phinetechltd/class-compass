import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class HeadingTypeButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final bool selected;
  final String title;
  const HeadingTypeButtonWidget({super.key, this.onTap, this.selected = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: CustomContainer(color: selected? systemPrimaryColor().withValues(alpha: .25) :
      Theme.of(context).hintColor,
          borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false, verticalPadding: 0,
        onTap: onTap,
        borderColor: selected? Theme.of(context).hintColor : null,
        border: Border.all(color: selected? systemPrimaryColor() : Theme.of(context).hintColor),
        child:  Padding(padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
          child: Center(child: Text(title, style: textRegular.copyWith(color: selected?
          systemPrimaryColor() : null))))),
    );
  }
}
