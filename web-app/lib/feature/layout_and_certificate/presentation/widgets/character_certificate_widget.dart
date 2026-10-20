import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/character_certificate_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CharacterCertificateView extends StatelessWidget {
  const CharacterCertificateView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        
        
            Align(
              alignment: Alignment.centerRight,
              child: IntrinsicWidth(
                child: CustomButton(
                  icon: const Icon(Icons.print, color: Colors.white),
                  text: "Print",
                  onTap: () async {
                    Get.dialog(
                      const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false,
                    );
        
                    try {
                      CharacterCertificatePrinter.printCharacterCertificate();
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    } finally {
                      if (Get.isDialogOpen!) Get.back();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
        
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institute?.schoolName ?? '',
                        style: textSemiBold.copyWith(fontSize: 16)),
                    Text(institute?.address ?? ''),
                    Text("Tel: ${institute?.phone ?? ''}"),
                    Text(institute?.eiinCode ?? ''),
                  ],
                ),
                Image.network(systemController.logoUrl, height: 60),
              ],
            ),
        
            const SizedBox(height: 20),
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
                "CHARACTER CERTIFICATE",
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
                style: const TextStyle(fontSize: 14, height: 1.6),
                children: [
                  const TextSpan(text: "This is to certify that "),
                  TextSpan(
                    text:
                    "${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''}",
                    style: textSemiBold,
                  ),
                  const TextSpan(text: ", son of "),
                  TextSpan(
                    text: data?.studentSession?.student?.fatherName ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: data?.studentSession?.student?.motherName ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " was a student of this institution from "),
                  TextSpan(
                    text: data?.studentSession?.session?.year ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " to "),
                  const TextSpan(
                    text: "30/06/2025",
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " in "),
                  TextSpan(
                    text:
                    "${data?.studentSession?.student?.studentGroup?.groupName ?? ''} Group",
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " with Roll Number "),
                  TextSpan(
                    text: data?.studentSession?.roll ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),
        
            const SizedBox(height: 20),
        
            const Text(
              "During his stay in this institution, his character and conduct were found to be good and satisfactory. He was regular in attendance and showed keen interest in his studies.",
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
        
            const SizedBox(height: 20),
        
            const Text(
              "I wish him all success in his future endeavors.",
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
        
            const SizedBox(height: 300),
        
            /// FOOTER / SIGNATURE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: ${AppConstants.currentDate}"),
                    Text("Place: ${institute?.address ?? ''}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    const SizedBox(height: 8),
                    const Text("------------------------------"),
                    const Text("Principal"),
                    Text(institute?.schoolName ?? ''),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}