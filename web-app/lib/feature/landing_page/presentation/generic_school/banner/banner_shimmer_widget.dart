import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class BannerShimmerWidget extends StatelessWidget {
  const BannerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = isDesktop ? screenWidth * 0.45 : isTablet ? screenWidth * 0.6 : screenWidth * 0.9;



    return Stack(alignment: Alignment.center, children: [

      ClipRRect(child: CustomImage(width: screenWidth, height: bannerHeight,
        image: "",
        fit: BoxFit.cover, placeholder: Images.bannerPlaceHolder,)),

      Container(width: screenWidth, height: bannerHeight,
          decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColorDark.withValues(alpha: 0.3),
                Theme.of(context).primaryColorDark.withValues(alpha: 0.6),
                Theme.of(context).primaryColorDark.withValues(alpha: 0.8),
              ]))),

      Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Text("banner_title_placeholder".tr, textAlign: TextAlign.center,
                style: textRegular.copyWith(
                    fontSize: isDesktop ? 46 : isTablet ? 32 : Dimensions.fontSizeExtraLarge,
                    color: Colors.white, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Text("banner_description_placeholder".tr, textAlign: TextAlign.center,
                style: textMedium.copyWith(
                    fontSize: isDesktop ? 20 : isTablet ? 16 : Dimensions.fontSizeDefault,
                    color: Colors.white, height: 1.4)),

            const SizedBox(height: 25),

            // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
            //     boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
            //         blurRadius: 20, spreadRadius: 2)]),
            //     child: SizedBox(width: isDesktop ? 180 : isTablet ? 160 : 140, height: 50,
            //         child: CustomButton(onTap: () {}, text: "apply_now".tr, borderRadius: 30))),
          ])),
      ),
    ]);
  }
}
