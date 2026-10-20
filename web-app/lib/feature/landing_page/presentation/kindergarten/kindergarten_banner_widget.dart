import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/banner_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/banner/banner_shimmer_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenBannerWidget extends StatefulWidget {
  final bool footer;
  const KindergartenBannerWidget({super.key, this.footer = false});

  @override
  State<KindergartenBannerWidget> createState() => _KindergartenBannerWidgetState();
}

class _KindergartenBannerWidgetState extends State<KindergartenBannerWidget> {
  int _currentIndex = 0;
  Timer? _timer;
  final bool _autoPlay = true;

  @override
  void initState() {
    super.initState();
    if (_autoPlay) _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final model = Get.find<LandingPageController>().bannerModel;
      final len = model?.data?.length ?? 0;
      if (len <= 1) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % len;
      });
    });
  }

  void _goToNext(int total) {
    if (total <= 0) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % total;
    });
    if (_autoPlay) _restartTimer();
  }

  void _goToPrev(int total) {
    if (total <= 0) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + total) % total;
    });
    if (_autoPlay) _restartTimer();
  }

  void _restartTimer() {
    if (!_autoPlay) return;
    _timer?.cancel();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<LandingPageController>(initState: (val) {
        if (Get.find<LandingPageController>().bannerModel == null) {
          Get.find<LandingPageController>().getBannerData();
        }
      },
      builder: (landingPageController) {
        BannerModel? bannerModel = landingPageController.bannerModel;

        return Container(decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(screenWidth / 5)),
            color: widget.footer? Theme.of(context).secondaryHeaderColor : systemLandingPagePrimaryColor()),
          width: screenWidth,
          child: bannerModel != null && (bannerModel.data?.isNotEmpty ?? false) ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: (details) {
              final vx = details.primaryVelocity ?? 0;
              final len = bannerModel.data!.length;
              if (vx < -200) {
                _goToNext(len);
              } else if (vx > 200) {
                _goToPrev(len);
              }
            },
            child: AnimatedSwitcher(duration: const Duration(milliseconds: 700),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: _buildBannerByIndex(context, screenWidth, bannerModel, _currentIndex, key: ValueKey<int>(_currentIndex))),)
              : const BannerShimmerWidget(),
        );
      },
    );
  }

  Widget _buildBannerByIndex(BuildContext context, double screenWidth, BannerModel bannerModel, int index, {Key? key}) {
    final banners = bannerModel.data!;
    final safeIndex = banners.isEmpty ? 0 : index % banners.length;
    final banner = banners[safeIndex];

    return SizedBox(key: key, width: screenWidth,
      child: Stack(children: [
        if(!widget.footer)
          Positioned(bottom: 0, left: 0, right: 0,
            child: Center(child: CustomImage(image: "${AppConstants.imageBaseUrl}/banners/${banner.image}", width: screenWidth / 1.5))),

        CustomImage(image: widget.footer?  Images.footerShape : Images.shape, localAsset: true, width: screenWidth),


          Padding(padding: const EdgeInsets.all(50),
            child: Column(spacing: Dimensions.paddingSizeLarge, children: [
                Text(banner.title ?? "Bright Beginnings Start Here – Nurturing Young Minds with Care & Joy!",
                  textAlign: TextAlign.center,
                    style: textHeavy.copyWith(color: widget.footer? Colors.white : null, fontSize: screenWidth * 0.04)),
                SizedBox(width: 520,
                  child: Text(banner.description ?? "At our kindergarten, we provide a safe, fun, and creative space where every child can learn, play, and grow.",
                    textAlign: TextAlign.center,
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: widget.footer? Colors.white : Theme.of(context).hintColor))),
                SizedBox(width: 120,
                  child: CustomButton(buttonColor: widget.footer? Colors.white : Theme.of(context).secondaryHeaderColor,
                    onTap: () {}, text: banner.buttonName??"enroll_now".tr, textColor: widget.footer? Theme.of(context).secondaryHeaderColor : Colors.white,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
