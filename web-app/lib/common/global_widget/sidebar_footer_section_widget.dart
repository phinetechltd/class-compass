import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/side_sheet_widget.dart';
import 'package:class_compass/feature/home/widget/subscription_widget.dart';
import 'package:class_compass/feature/user_manual/presentation/user_manual_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class SidebarFooterSectionWidget extends StatelessWidget {
  final String roleType;
  const SidebarFooterSectionWidget({super.key, required this.roleType});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [

      if(AppConstants.demo)
      InkWell(onTap: () {
        showModalSideSheet(Get.context!,
            barrierDismissible: true,
            addBackIconButton: false,
            addActions: false,
            addDivider: false,
            body: const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: UserManualWidget()),
            header: "user_manual".tr);
      },
        child: Container(height: 70, decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(spacing: Dimensions.paddingSizeDefault,children: [
                 CustomImage(width: 30, image: Images.userManual, localAsset: true,
                localAssetColor: Theme.of(context).hintColor),
                Text("user_manual".tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.displayLarge?.color, fontSize: Dimensions.fontSizeLarge),),
                ],
              ),
            )),
      ),

      roleType == "Super Admin"?
      const SubscriptionWidget():const SizedBox()
    ],);
  }
}
