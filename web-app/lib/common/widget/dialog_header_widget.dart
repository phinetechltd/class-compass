import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class DialogHeaderWidget extends StatelessWidget {
  final String title;
  const DialogHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
            IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.close_rounded, color: Theme.of(context).hintColor, size: 20,)),
          ],
        ));
  }
}
