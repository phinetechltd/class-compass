import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class FromToSelectionWidget extends StatelessWidget {
  final Function()? onTap;
  const FromToSelectionWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: CustomContainer(
        child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.end, children : [
           Expanded(child: DateSelectionWidget(title: "from".tr, end: false)),
           Expanded(child: DateSelectionWidget(title: "to".tr, end: true)),
          IntrinsicWidth(child: CustomButton(onTap: onTap, text: "search".tr, width: 120, height: 40))

        ]),
      ),
    );
  }
}
