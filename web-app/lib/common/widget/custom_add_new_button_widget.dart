import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/styles.dart';

class CustomAddNewButtonWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const CustomAddNewButtonWidget({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(onTap: onTap,
        verticalPadding: 5, borderRadius: 5, color: systemPrimaryColor(),
        child: Text(title?? '', style: textRegular.copyWith(color: Colors.white)));
  }
}
