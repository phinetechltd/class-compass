import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CustomBottomNavigationButton extends StatelessWidget {
  final String title;
  final String? icon;
  final Function()? onTap;
  const CustomBottomNavigationButton({super.key, required this.title, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: ThemeShadow.getShadow()),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: CustomButton(icon: icon != null? SizedBox(width: 15, child: Image.asset(icon!)): const Icon(Icons.add, size: 20),
            onTap: onTap,
            textColor: Theme.of(context).textTheme.displayLarge!.color!,
            buttonColor: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,
            text: title.tr),
      ),
    );
  }
}
