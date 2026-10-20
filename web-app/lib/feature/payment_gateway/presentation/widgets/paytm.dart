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

class PaytmPaymentGatewayCardItem extends StatefulWidget {
  const PaytmPaymentGatewayCardItem({super.key});

  @override
  State<PaytmPaymentGatewayCardItem> createState() => _PaytmPaymentGatewayCardItemState();
}

class _PaytmPaymentGatewayCardItemState extends State<PaytmPaymentGatewayCardItem> {

  TextEditingController merchantKeyController = TextEditingController();
  TextEditingController merchantIdController = TextEditingController();
  TextEditingController merchantWebsiteLinkController = TextEditingController();

  @override
  void initState() {
    merchantKeyController.text = Get.find<PaymentGatewayController>().payTmPaymentGatewayItem?.paymentInfo?.merchantKey ?? "";
    merchantIdController.text = Get.find<PaymentGatewayController>().payTmPaymentGatewayItem?.paymentInfo?.merchantId ?? "";
    merchantWebsiteLinkController.text = Get.find<PaymentGatewayController>().payTmPaymentGatewayItem?.paymentInfo?.merchantWebsiteLink ?? "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.payTmPaymentGatewayItem;
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

              const CustomImage( height: 30, image: Images.payTm, localAsset: true,),


              CustomTextField(title: "merchant_key".tr,
                controller: merchantKeyController,
                hintText: paymentGatewayItem.paymentInfo?.publicKey,),

              CustomTextField(title: "merchant_id".tr,
                controller: merchantIdController,
                hintText: paymentGatewayItem.paymentInfo?.secretKey,),


              CustomTextField(title: "merchant_website_link".tr,
                controller: merchantWebsiteLinkController,
                hintText: paymentGatewayItem.paymentInfo?.secretKey,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String merchantKey = merchantKeyController.text.trim();
                String merchantId = merchantIdController.text.trim();
                String merchantWebsiteLink = merchantWebsiteLinkController.text.trim();

               if(merchantKey.isEmpty){
                  showCustomSnackBar("merchant_key_is_empty".tr);
                }
                else if(merchantId.isEmpty){
                  showCustomSnackBar("merchant_id_is_empty".tr);
                }
                else if(merchantWebsiteLink.isEmpty){
                  showCustomSnackBar("merchant_website_link_is_empty".tr);
                }else if(AppConstants.demo) {
                 showCustomSnackBar(AppConstants.demoModeMessage.tr);
               }
                else{
                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      name: paymentGatewayItem.name,
                      paymentInfo: PaymentInfo(merchantKey: merchantKey, merchantId: merchantId, merchantWebsiteLink: merchantWebsiteLink)));
                }
              }, text: "save".tr))
            ])):const SizedBox();
      }
    );
  }
}
