import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/recommandation_letter_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class RecommendationLetterPreviewPage extends StatelessWidget {
  const RecommendationLetterPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: CustomContainer(verticalPadding: 50,horizontalPadding: 50,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Align(alignment: Alignment.centerRight,
            child: IntrinsicWidth(child: CustomButton(
              icon: const Icon(Icons.print_outlined, color: Colors.white),
              onTap: () async {
                Get.dialog(
                  Dialog(child: CustomContainer(verticalPadding: Dimensions.paddingSizeOverLarge,
                      child: Column(spacing: Dimensions.paddingSizeDefault,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          Text("please_wait_a_while_pdf_are_generating".tr),
                        ],
                      )),
                  ),
                  barrierDismissible: false,
                );

                try {
                  RecommendationLetterPrinter.printRecommendationLetter();

                } catch (e) {
                  Get.snackbar("Error", e.toString());
                } finally {
                  if (Get.isDialogOpen!) Get.back();
                }
              },
              text: "print".tr,
            )
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(institute?.schoolName ?? '',
                  style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              Text(institute?.address ?? ''),
              Text("Tel: ${institute?.phone ?? ''}"),
            ]),

            Image.network(systemController.logoUrl, height: 60),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(institute?.schoolName ?? '', style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                Text(institute?.address ?? ''),
                Text("Tel: ${institute?.phone ?? ''}"),
              ]),
          ]),

          const Divider(thickness: 2),

          Align(alignment: Alignment.centerRight,
            child: Text("Date: ${AppConstants.currentDate}",
                style: textSemiBold.copyWith())),

          const SizedBox(height: 20),

          Center(child: Text("TO WHOM IT MAY CONCERN",
              style: textSemiBold.copyWith(decoration: TextDecoration.underline))),

          const SizedBox(height: 24),

          Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'This is to certify that '),
              TextSpan(text:
              '${data?.studentSession?.student?.firstName} ${data?.studentSession?.student?.lastName}',
                  style: textSemiBold.copyWith()),
              const TextSpan(text: ' is a student of '),
              TextSpan(text: institute?.schoolName ?? '',
                  style: textSemiBold.copyWith(fontStyle: FontStyle.italic)),
                ],
            )),

          const SizedBox(height: 40),
          const Text("Any assistance given to him will be highly appreciated."),
          const SizedBox(height: 300),

          const Align(
            alignment: Alignment.centerRight,
            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Sincerely"),
                SizedBox(height: 40),
                Text("-------------------------"),
                Text("Principal"),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}