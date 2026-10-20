import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/payment_gateway/domain/model/payment_gateway_model.dart';
import 'package:class_compass/feature/payment_gateway/logic/payment_gateway_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class StripePaymentGatewayCardItem extends StatefulWidget {
  const StripePaymentGatewayCardItem({super.key});

  @override
  State<StripePaymentGatewayCardItem> createState() => _StripePaymentGatewayCardItemState();
}

class _StripePaymentGatewayCardItemState extends State<StripePaymentGatewayCardItem> {

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController publishedKeyController = TextEditingController();

  @override
  void initState() {
    apiKeyController.text = Get.find<PaymentGatewayController>().stripePaymentGatewayItem?.paymentInfo?.apiKey ?? "";
    publishedKeyController.text = Get.find<PaymentGatewayController>().stripePaymentGatewayItem?.paymentInfo?.publishedKey ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.stripePaymentGatewayItem;
        return paymentGatewayItem != null?
        CustomContainer(borderRadius: Dimensions.radiusSmall,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
              Row(children: [
                Expanded(child: Text('${paymentGatewayItem.name?.toUpperCase().replaceAll("_", " ")}', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                ActiveInActiveWidget(active: paymentGatewayItem.status == "1",
                    onChanged: (onChanged){
                      saasPaymentGatewayController.paymentGatewayStatusUpdate(paymentGatewayItem.id!);
                    }),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),

              const CustomImage( height: 50, image: Images.stripe, localAsset: true,),


              CustomTextField(title: "api_key".tr,
                controller: apiKeyController,
                hintText: paymentGatewayItem.paymentInfo?.apiKey,),

              CustomTextField(title: "published_key".tr,
                controller: publishedKeyController,
                hintText: paymentGatewayItem.paymentInfo?.publishedKey,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String apiKey = apiKeyController.text.trim();
                String publishedKey = publishedKeyController.text.trim();
                if(apiKey.isEmpty) {
                  showCustomSnackBar("api_key_is_empty".tr);
                } else if(publishedKey.isEmpty) {
                  showCustomSnackBar("published_key_is_empty".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {

                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      paymentInfo: PaymentInfo(apiKey: apiKey, publishedKey: publishedKey),
                     ));
                }
              }, text: "save".tr))
            ])):const SizedBox();
      }
    );
  }
}
