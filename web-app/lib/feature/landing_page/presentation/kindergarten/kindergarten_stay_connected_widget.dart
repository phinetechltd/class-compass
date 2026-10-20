import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/mobile_app_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenStayConnectedWidget extends StatelessWidget {
  const KindergartenStayConnectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.mobileAppModel == null) {
          landingPageController.getMobileAppData();
        }
      },
      builder: (landingPageController) {
        MobileAppModel? mobileAppModel = landingPageController.mobileAppModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return mobileAppModel != null?

         isDesktop?
        Center(
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 50, horizontal: Dimensions.paddingSizeDefault),
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Center(
                child: CustomContainer(color: Theme.of(context).secondaryHeaderColor,height: 300,
                  child: Stack(clipBehavior: Clip.none,
                    children: [
                      const Positioned(right: 50,  bottom: -10,
                          child: CustomImage(width: 500, image: Images.parentApp, localAsset: true)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(spacing: Dimensions.paddingSizeExtraLarge, children: [

                            Expanded(
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                spacing: Dimensions.paddingSizeDefault, children: [
                                 SizedBox(width: 450,
                                   child: Text(mobileAppModel.data?.first.title??'',
                                       style: textBold.copyWith(fontSize: 40, color: Colors.white)),
                                 ),



                                   Row(spacing: Dimensions.paddingSizeDefault, children: [
                                      InkWell(onTap: ()=> AppConstants.openUrl(mobileAppModel.data?.first.playStoreLink??''),
                                          child: const CustomImage(image: Images.playStore, height: 40, localAsset: true,)),

                                     InkWell(onTap: ()=> AppConstants.openUrl(mobileAppModel.data?.first.appStoreLink??''),
                                          child: const CustomImage(image: Images.appStore,height: 40, localAsset: true,))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ):

         Padding(
           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
           child: Column(spacing: Dimensions.paddingSizeDefault ,mainAxisAlignment: MainAxisAlignment.center, children: [
             CustomImage(width: Get.width,image: mobileAppModel.data?.first.image??''),
            Text(mobileAppModel.data?.first.title??'', style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).colorScheme.primary)),
             Container(height: 3, width: 60, decoration: BoxDecoration(color: systemLandingPagePrimaryColor(), borderRadius: BorderRadius.circular(50))),
             Text(mobileAppModel.data?.first.description??'', style: textRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, color: Theme.of(context).hintColor),),


            Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
              FeatureItemWidget(title: mobileAppModel.data?.first.featureOne),
              FeatureItemWidget(title: mobileAppModel.data?.first.featureTwo),
              FeatureItemWidget(title: mobileAppModel.data?.first.featureThree),
            ],),

             const SizedBox(height: Dimensions.paddingSizeDefault),

             Row(mainAxisAlignment: MainAxisAlignment.center, spacing: Dimensions.paddingSizeDefault, children: [
               InkWell(onTap: ()=> AppConstants.openUrl(mobileAppModel.data?.first.playStoreLink??''),
                   child: const CustomImage(image: Images.playStore, height: 40, localAsset: true,)),

               InkWell(onTap: ()=> AppConstants.openUrl(mobileAppModel.data?.first.appStoreLink??''),
                   child: const CustomImage(image: Images.appStore,height: 40, localAsset: true,))
             ])
           ])) :const SizedBox();
      }
    );
  }
}

class FeatureItemWidget extends StatelessWidget {
  final String? title;
  const FeatureItemWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return Row(spacing : Dimensions.paddingSizeSmall,mainAxisAlignment:isDesktop?MainAxisAlignment.start: MainAxisAlignment.center,children: [
      Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 18,),
      Text(title??'', style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 16),)
    ],);
  }
}
