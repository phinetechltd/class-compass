import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/package_plan/controller/package_controller.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/feature/package_plan/presentation/widgets/call_widget.dart';
import 'package:class_compass/feature/package_plan/presentation/widgets/purchase_subscription_plan_widget.dart';
import 'package:class_compass/feature/profile/domain/model/profile_model.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SubscriptionItem extends StatelessWidget {
  final int index;
  final PackageItem? packageItem;
  const SubscriptionItem({super.key, required this.index, this.packageItem});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;
        return GetBuilder<PackageController>(
          builder: (instituteController) {
            return Stack(children: [
                CustomContainer(border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                  showShadow: false,
                  borderRadius: Dimensions.paddingSizeExtraSmall,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(packageItem?.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    if(packageItem?.name?.toLowerCase() != "enterprise" && packageItem!.price! > 0)
                    Row(children: [
                        Text(PriceConverter.convertPrice(context, packageItem?.price??0),
                            style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                      ]),

                    Text("${"duration".tr} : ${packageItem?.durationDays?.toString()??''} ${"days".tr}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

                    Row(children: [
                      Flexible(child: Text(packageItem?.description??'', style: textRegular.copyWith())),
                      if(packageItem?.name?.toLowerCase() == "enterprise")
                      const Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: CallWidget()),
                      ]),
                    //if(MediaQuery.sizeOf(context).width>1000)


                    if(profileModel != null)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                      child: _buildPopupMenu(context, profileModel.data!.instituteInfo!.id!),
                    ),

                  ],),),
              ],
            );
          }
        );
      }
    );
  }
  Widget _buildPopupMenu(BuildContext context, int instituteId) {
    return CustomPopupMenu(
      menuItems: Get.find<DashboardController>().getPopupMenuList(subscription: true),
      onSelected: (option) {
        if (option.title == "subscription_upgrade_request".tr) {
          Get.find<PackageController>().updateSubscriptionPlan(packageItem!.id!,instituteId);
        }else if(option.title == "payment".tr){
          Get.dialog(const PurchaseSubscriptionPlanWidget());
        }
      },
      child: CustomContainer(color: Theme.of(context).primaryColor,borderRadius: 5,
          child: Text("subscribe".tr, style: textBold.copyWith(color: Colors.white))),
    );
  }
}
