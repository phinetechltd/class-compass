import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/payment_gateway/logic/payment_gateway_controller.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/mpesa.dart';
import 'package:class_compass/feature/payment_gateway/presentation/widgets/paystack.dart';

/// School payment gateway settings: M-Pesa (Daraja) and Paystack credentials.
class PaymentGatewaySetupWidget extends StatefulWidget {
  const PaymentGatewaySetupWidget({super.key});

  @override
  State<PaymentGatewaySetupWidget> createState() => _PaymentGatewaySetupWidgetState();
}

class _PaymentGatewaySetupWidgetState extends State<PaymentGatewaySetupWidget> {
  @override
  void initState() {
    super.initState();
    Get.find<PaymentGatewayController>().getSaasPaymentGateway();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(builder: (controller) {
      if (controller.paymentGatewayModel == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MpesaPaymentGatewayCardItem(),
          SizedBox(height: 24),
          PayStackPaymentGatewayCardItem(),
        ],
      );
    });
  }
}
