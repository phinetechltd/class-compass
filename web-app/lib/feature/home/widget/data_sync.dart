import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class DataSyncWidget extends StatelessWidget {
  const DataSyncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Text("please_wait".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeHeading)),
          SizedBox(height: Get.width/3, child: const CustomImage(image: Images.database, localAsset: true,width: 100)),
        ],
    ),);
  }
}
