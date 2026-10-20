import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/shimmer_box.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FaqLoadingWidget extends StatelessWidget {
  const FaqLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(width: Dimensions.webMaxWidth,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text("faq".tr, style: textMedium.copyWith(color: systemLandingPagePrimaryColor(), fontSize: 20)),
        Text("have_question".tr, style: textBold.copyWith(fontSize: 40, color: Theme.of(context).colorScheme.primary)),
        Container(height: 3, width: 60, decoration: BoxDecoration(color: systemLandingPagePrimaryColor(), borderRadius: BorderRadius.circular(50))),
        const SizedBox( height: Dimensions.paddingSizeDefault),
        ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding:  EdgeInsets.zero,
            itemBuilder: (context, index){
              return Container(margin:const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomShimmerBox(width: Get.width/1.5, height: Get.height/20));
            })
      ],
      ),
    ),
    );
  }
}
