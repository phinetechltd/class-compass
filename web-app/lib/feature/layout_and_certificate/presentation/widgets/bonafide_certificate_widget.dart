import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/bonafide_certificate_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BonafideCertificateWidget extends StatelessWidget {
  const BonafideCertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: CustomContainer(
        verticalPadding: 50,
        horizontalPadding: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Align(alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                      text: "Print", onTap: () {
                        BonafideCertificatePrinter.printCertificate();
                      }),
                )),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institute?.schoolName ?? '',
                        style: textSemiBold.copyWith(fontSize: 18)),
                    Text(institute?.address ?? ''),
                    Text("Tel: ${institute?.phone ?? ''}"),
                    Text(institute?.eiinCode ?? ''),
                  ],
                ),

                Image.network(systemController.logoUrl, height: 60),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institute?.schoolName ?? '',
                        style: textSemiBold.copyWith(fontSize: 18)),
                    Text(institute?.address ?? ''),
                    Text("Tel: ${institute?.phone ?? ''}"),
                    Text(institute?.eiinCode ?? ''),
                  ],
                ),
              ],
            ),

            const Divider(thickness: 2),
            const SizedBox(height: 20),

            /// DATE
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Date: ${AppConstants.currentDate}",
                style: textSemiBold,
              ),
            ),
            const SizedBox(height: 30),

            /// TITLE
            Center(
              child: Text(
                "BONAFIDE CERTIFICATE",
                style: textSemiBold.copyWith(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// BODY
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                children: [
                  const TextSpan(text: "This is to certify that "),
                  TextSpan(
                    text:
                    "${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''} (Roll # ${data?.studentSession?.roll ?? '--'})",
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " , son of "),
                  TextSpan(
                    text: data?.studentSession?.student?.fatherName ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: data?.studentSession?.student?.motherName ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " is a bonafide student of this institution studying in "),
                  TextSpan(
                    text: data?.studentSession?.classItem?.className ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: ", "),
                  TextSpan(
                    text: data?.studentSession?.student?.studentGroup?.groupName ?? '',
                    style: textSemiBold.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(text: " group for the session of "),
                  TextSpan(
                    text: data?.studentSession?.session?.year ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "He is a regular and disciplined student of this institution.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const Text(
              "This certificate is issued on his request for official purposes.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 50),

            /// SIGNATURE
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Sincerely"),
                  const SizedBox(height: 40),
                  const Text("------------------------------"),
                  const Text("Principal"),
                  Text(institute?.schoolName ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}