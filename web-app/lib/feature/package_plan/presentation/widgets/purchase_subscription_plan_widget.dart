import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/feature/digital_payment/domain/models/digital_payment_body.dart';
import 'package:class_compass/feature/digital_payment/logic/digital_payment_controller.dart';
import 'package:class_compass/feature/package_plan/controller/package_controller.dart';
import 'package:class_compass/feature/package_plan/presentation/widgets/package_pricing_widget.dart';
import 'package:class_compass/feature/package_plan/presentation/widgets/select_payment_type_widget.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:universal_html/html.dart' as html;

class PurchaseSubscriptionPlanWidget extends StatelessWidget {
  const PurchaseSubscriptionPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DigitalPaymentController>(builder: (digitalPaymentController) {
      return GetBuilder<PackageController>(builder: (packageController) {
        return Dialog(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeSmall,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const PackagePricingWidget(),
                  const SelectPaymentTypeWidget(),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Align(alignment: Alignment.centerRight, child: CustomButton(width: 120, onTap: (){
                    int? instituteId = Get.find<ProfileController>().profileModel?.data?.instituteId;//instituteController.onboardingModel!.data!.user!.instituteId!;
                    String? hostname = html.window.location.hostname;
                    String protocol = html.window.location.protocol;
                    String callbackUrl = '$protocol//$hostname${RouteHelper.getDashboardRoute()}';
                    DigitalPaymentBody body = DigitalPaymentBody(
                      paymentMethod: "${packageController.selectedPaymentType}",
                      paymentType: "subscription_payment",
                      paymentPlatform: "web",
                      planId: packageController.selectedPackageItem?.id.toString(),
                      amount: packageController.selectedPackageItem?.price,
                      currency: AppConstants.currency,
                      externalRedirectLink: callbackUrl,
                      successHook: callbackUrl,
                      failureHook: callbackUrl,
                      name: Get.find<ProfileController>().profileModel?.data?.name,
                      phone: Get.find<ProfileController>().profileModel?.data?.phone,
                      email: Get.find<ProfileController>().profileModel?.data?.email,

                    );
                    if(packageController.selectedPackageItem?.price == 0){
                      packageController.updateSubscriptionPlan(packageController.selectedPackageItem!.id!, instituteId!);
                    }else{
                      digitalPaymentController.makeDigitalPayment(body);
                    }


                  }, text: "confirm".tr))

                ],
              ),
            ));
      }
      );
    }
    );
  }
}
