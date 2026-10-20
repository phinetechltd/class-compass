import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/abroad_letter_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class AbroadLetterWidget extends StatelessWidget {
  const AbroadLetterWidget({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      await AbroadLetterPrinter.printAbroadLetter();
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
                "TO WHOM IT MAY CONCERN",
                style: textSemiBold.copyWith(
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
                  const TextSpan(text: " was a student of "),
                  TextSpan(
                    text: institute?.schoolName ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(text: " in "),
                  TextSpan(
                    text: data?.studentSession?.student?.studentGroup?.groupName ?? '',
                    style: textSemiBold.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(text: " group in the session of "),
                  TextSpan(
                    text: data?.studentSession?.session?.year ?? '',
                    style: textSemiBold,
                  ),
                  const TextSpan(
                      text:
                      ". He appeared in the HSC Exam under Board of Intermediate and Secondary Education, Dhaka bearing "),
                  TextSpan(
                    text: "Roll: ${data?.studentSession?.roll ?? '--'}",
                    style: textSemiBold,
                  ),
                  const TextSpan(text: ". He passed successfully."),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "To the best of my knowledge he did not participate in any anti-state activity and bears a good moral character.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 20),

            const Text(
              "Any assistance given to him will be highly appreciated.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 300),

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