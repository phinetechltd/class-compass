import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/payment_gateway/domain/model/payment_gateway_model.dart';
import 'package:class_compass/feature/payment_gateway/logic/payment_gateway_controller.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/bkash.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/flutterwave.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/mpesa.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/paymob_accept.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/paypal.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/paystack.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/paytm.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/razor_pay.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/senang_pay.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/ssl_commerz.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/stripe.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PaymentGatewayWidget extends StatefulWidget {
  const PaymentGatewayWidget({super.key});

  @override
  State<PaymentGatewayWidget> createState() => _PaymentGatewayWidgetState();
}

class _PaymentGatewayWidgetState extends State<PaymentGatewayWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      initState: (_) {
        Get.find<PaymentGatewayController>().getSaasPaymentGateway();
      },
      builder: (saasPaymentGatewayController) {
        PaymentGatewayModel? saasPaymentGatewayModel = saasPaymentGatewayController.paymentGatewayModel;

        return Column(children: [

          SectionHeaderWithPath(sectionTitle: "payment_gateway".tr),


          (saasPaymentGatewayModel != null && saasPaymentGatewayModel.data != null)?
           Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ResponsiveHelper.isDesktop(context)?
            const Column(spacing: Dimensions.paddingSizeLarge, children: [

              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: MpesaPaymentGatewayCardItem()),
                Expanded(child: PayStackPaymentGatewayCardItem()),
              ]),

              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: StripePaymentGatewayCardItem()),
                Expanded(child: SslCommerzPaymentGatewayCardItem()),
              ]),

              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: PaypalPaymentGatewayCardItem()),
                Expanded(child: SenangPayPaymentGatewayCardItem()),
              ]),

                Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Expanded(child: RazorPayPaymentGatewayCardItem()),
                  Expanded(child: FlutterWavePaymentGatewayCardItem()),

                ]),



              Row(spacing: Dimensions.paddingSizeLarge, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: PaytmPaymentGatewayCardItem()),
                Expanded(child: SizedBox()),
              ]),



              Row(spacing: Dimensions.paddingSizeLarge,children: [
                Expanded(child: PaymobAcceptPaymentGatewayCardItem()),
                Expanded(child: BkashPaymentGatewayCardItem())
              ]),
              ],
            ):const Column(spacing: Dimensions.paddingSizeLarge, children: [

              MpesaPaymentGatewayCardItem(),
              PayStackPaymentGatewayCardItem(),
              StripePaymentGatewayCardItem(),
              SslCommerzPaymentGatewayCardItem(),

              PaypalPaymentGatewayCardItem(),
              SenangPayPaymentGatewayCardItem(),

              RazorPayPaymentGatewayCardItem(),
              FlutterWavePaymentGatewayCardItem(),

              PaytmPaymentGatewayCardItem(),

              PaymobAcceptPaymentGatewayCardItem(),
              BkashPaymentGatewayCardItem(),
            ],
            ),
          ):  Center(child: Padding(padding: ThemeShadow.getPadding(),
              child: const CircularProgressIndicator())),
        ]);
      }
    );
  }
}

