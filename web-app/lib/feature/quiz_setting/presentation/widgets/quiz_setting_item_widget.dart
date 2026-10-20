import 'package:flutter/material.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuizSettingItemWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const QuizSettingItemWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
      Expanded(flex: 2, child: Text(title, style: textRegular)),
      Expanded(flex: 10, child: child)
    ]);
  }
}
