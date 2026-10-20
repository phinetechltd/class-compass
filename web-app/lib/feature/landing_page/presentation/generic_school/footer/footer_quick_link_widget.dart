import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/web_app_bar.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';

class FooterQuickLinkWidget extends StatelessWidget {
  const FooterQuickLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        return ListView.builder(
            itemCount: landingPageController.menuList.length,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return MenuButtonWeb(onTap: (){
                if(index == 1){
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
              }, title: landingPageController.menuList[index].tr);
            });
      }
    );
  }
}
