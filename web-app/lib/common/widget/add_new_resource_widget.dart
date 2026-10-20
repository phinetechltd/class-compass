import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/styles.dart';

class AddNewResourceWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final double? width;
  const AddNewResourceWidget({super.key, this.title, this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(onTap: onTap,
      verticalPadding: 5, horizontalPadding: 5, showShadow: false,
      width: width?? 128, border: Border.all(color: systemPrimaryColor(), width: .5),
      borderRadius: 5,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.add, color: systemPrimaryColor(),size: 16),
        Text(title??'', style: textRegular.copyWith(color: systemPrimaryColor()),)
      ]),
    );
  }
}
