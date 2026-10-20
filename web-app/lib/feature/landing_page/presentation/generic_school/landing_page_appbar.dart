
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/side_sheet_widget.dart';
import 'package:class_compass/common/widget/text_hover.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/announcement_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/widgets/logo_section_widget.dart';
import 'package:class_compass/feature/profile/presentation/widgets/header_profile_info_dropdown.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/localization/controller/localization_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class LandingPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LandingPageAppBar({super.key, required});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (languageController) {
      return GetBuilder<LandingPageController>(builder: (landingPageController) {
        return Container(decoration: BoxDecoration(boxShadow: ThemeShadow.getShadow(),
            color: Theme.of(context).cardColor),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const AnnouncementWidget(),

            Center(child: Padding(padding:  EdgeInsets.symmetric(vertical: 5, horizontal: ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
              child: SizedBox(width: Dimensions.webMaxWidth,
                child: Row(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, children: [
                  const LogoSectionWidget(),

                  const Spacer(),
                  ResponsiveHelper.isDesktop(context)?
                  Row(children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(height: 40,
                        child: ListView.builder(
                                  itemCount: landingPageController.menuList.length,
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return MenuButtonWeb(onTap: (){
                                      if(index == 1){
                                        Get.toNamed(RouteHelper.getInitialRoute());
                                        landingPageController.scrollToSection(4);
                                      }else if(index == 2){
                                        landingPageController.scrollToSection(6);
                                      }else if(index == 3){
                                        landingPageController.scrollToSection(1);
                                      }else if(index == 6){
                                        landingPageController.scrollToSection(8);
                                      }else{
                                        landingPageController.scrollToSection(index);
                                      }
                                    },
                                        title: landingPageController.menuList[index].tr);
                                  }),
                            )),


                          const SizedBox(width: Dimensions.paddingSizeDefault),
                          GetBuilder<AuthenticationController>(builder: (authenticationController) {
                            return authenticationController.isLoggedIn()?
                            const HeaderProfileInfoMenu():
                            IntrinsicWidth(child: CustomButton(
                              buttonColor: systemLandingPagePrimaryColor(),
                                height: 35, onTap: (){
                              Get.toNamed(RouteHelper.getSignInRoute());
                              }, text: "login".tr));
                          }),
                  ]):
                  InkWell(onTap: (){
                    showModalSideSheet(context,
                        barrierDismissible: true,
                        addBackIconButton: false,
                        addActions: false,
                        addDivider: false,
                        body: ListView.builder(
                            itemCount: landingPageController.menuList.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              return MenuButtonWeb(onTap: (){
                                Get.back();
                                },
                                  title: landingPageController.menuList[index].tr);
                            }),
                        header: AppConstants.appName);
                    },
                      child: const CustomImage(image: Images.menuIcon, localAsset: true, height: 20)),




                      ]),
                    ),
                  )),
                ],
                ),
              );
            }
          );
        }
    );
  }




  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 120);
}


class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final Function() onTap;

  const MenuButtonWeb({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
        return AnimatedContainer(duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: hovered ? Get.find<FrontendSettingsController>().primaryColor
                 : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
          ),
          child: InkWell(hoverColor: Colors.transparent, onTap: onTap,
            child: Padding(padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
              child: AnimatedDefaultTextStyle(duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut, style: textMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: hovered ? Dimensions.fontSizeExtraLarge + 2
                      : Dimensions.fontSizeExtraLarge,),
                child: Center(child: Text(title!, style: textRegular))),
            ),
          ),
        );
      },
    );
  }
}




