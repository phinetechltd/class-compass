import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/authentication/presentation/screen/login_screen.dart';
import 'package:class_compass/feature/menu_section/presentation/widgets/menu_item_widget.dart';
import 'package:class_compass/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:class_compass/feature/profile/presentation/widgets/password_update_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';


class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  @override
  void initState() {
    Get.find<ParentProfileController>().getProfileInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "profile".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
              const PasswordUpdateWidget(),

              TitleButton(icon: Images.logout, title: 'logout', onTap: (){
                Get.find<AuthenticationController>().clearSharedData();
                Get.offAll(()=> const LoginScreen());
              },),
            ])))
      ]),
    );
  }
}
