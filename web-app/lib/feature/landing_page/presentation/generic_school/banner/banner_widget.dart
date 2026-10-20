import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/banner_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/banner/banner_shimmer_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/banner/banner_text_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/images.dart';



class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = isDesktop ? screenWidth * 0.45 :
    isTablet ? screenWidth * 0.6 : screenWidth * 0.56;

    return GetBuilder<LandingPageController>(
      initState: (val) {
        if (Get.find<LandingPageController>().bannerModel == null) {
          Get.find<LandingPageController>().getBannerData();
        }
      },
      builder: (landingPageController) {
        BannerModel? bannerModel = landingPageController.bannerModel;
        return SizedBox(height: bannerHeight, width: screenWidth,
          child: (bannerModel != null && bannerModel.data?.isNotEmpty == true)?
        CarouselSlider.builder(itemCount: bannerModel.data?.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            final banner = bannerModel.data?[itemIndex];
            return Stack(alignment: Alignment.center, children: [

              ClipRRect(child: CustomImage(width: screenWidth, height: bannerHeight,
                  image: "${AppConstants.imageBaseUrl}/banners/${banner?.image}",
                  fit: BoxFit.cover, placeholder: Images.bannerPlaceHolder,)),

              Container(width: screenWidth, height: bannerHeight,
                  decoration: BoxDecoration(gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColorDark.withValues(alpha: 0.3),
                        Theme.of(context).primaryColorDark.withValues(alpha: 0.6),
                        Theme.of(context).primaryColorDark.withValues(alpha: 0.8),
                      ]))),

              BannerTextWidget(banner: banner)
            ]);
          },
          options: CarouselOptions(autoPlay: (bannerModel.data?.length ?? 0) > 2, viewportFraction: 1, initialPage: 0),
        ) : const BannerShimmerWidget(),
        );
      },
    );
  }
}

