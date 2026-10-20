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

class FlutterWavePaymentGatewayCardItem extends StatefulWidget {
  const FlutterWavePaymentGatewayCardItem({super.key});

  @override
  State<FlutterWavePaymentGatewayCardItem> createState() => _FlutterWavePaymentGatewayCardItemState();
}

class _FlutterWavePaymentGatewayCardItemState extends State<FlutterWavePaymentGatewayCardItem> {

  TextEditingController publicKeyController = TextEditingController();
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController hashController = TextEditingController();

  @override
  void initState() {
    final paymentInfo = Get.find<PaymentGatewayController>().flutterWavePaymentGatewayItem?.paymentInfo;
    publicKeyController.text = paymentInfo?.publicKey ?? "";
    secretKeyController.text = paymentInfo?.secretKey ?? "";
    hashController.text = paymentInfo?.encryptionKey ?? "";

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(builder: (saasPaymentGatewayController) {
      PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.flutterWavePaymentGatewayItem;
        return paymentGatewayItem != null?
        CustomContainer(borderRadius: Dimensions.radiusSmall,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Dimensions.paddingSizeExtraSmall, children: [
              Row(children: [
                Expanded(child: Text('${paymentGatewayItem.name?.toUpperCase().replaceAll("_", " ")}',
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),

                ActiveInActiveWidget(active: paymentGatewayItem.status == "1",
                    onChanged: (onChanged){
                      saasPaymentGatewayController.paymentGatewayStatusUpdate(paymentGatewayItem.id!);
                    }),


              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),

               const CustomImage( height: 50, image: Images.flutterWave, localAsset: true),


              CustomTextField(title: "public_key".tr,
                controller: publicKeyController,
                hintText: paymentGatewayItem.paymentInfo?.publicKey,),

              CustomTextField(title: "secret_key".tr,
                controller: secretKeyController,
                hintText: paymentGatewayItem.paymentInfo?.secretKey,),


              CustomTextField(title: "encryption_key".tr,
                controller: hashController,
                hintText: paymentGatewayItem.paymentInfo?.encryptionKey,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight,
                  child: CustomButton(width: 100, onTap: (){
                String publicKey = publicKeyController.text.trim();
                String secretKey = secretKeyController.text.trim();
                String hash = hashController.text.trim();
                if(publicKey.isEmpty) {
                  showCustomSnackBar("public_key_is_empty".tr);
                }
                else if(secretKey.isEmpty) {
                  showCustomSnackBar("secret_key_is_empty".tr);
                }
                else if(hash.isEmpty) {
                  showCustomSnackBar("hash_is_empty".tr);
                }
                else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {
                  saasPaymentGatewayController.editPaymentGateway(
                      PaymentGatewayItem(id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      name: paymentGatewayItem.name,
                      paymentInfo: PaymentInfo(publicKey: publicKey,
                          secretKey: secretKey, encryptionKey: hash),
                  ));
                }
              }, text: "save".tr))
            ])):const SizedBox();
      }
    );
  }
}
