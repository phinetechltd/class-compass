import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/study_certificate_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class StudyCertificatePreviewWidget extends StatelessWidget {
  const StudyCertificatePreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: CustomContainer(
          horizontalPadding: Dimensions.paddingSizeLarge,
          verticalPadding: Dimensions.paddingSizeLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
                    child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                        text: "Print", onTap: () async {
                          await StudyCertificatePrinter.printStudyCertificate();
                        }),
                  )),
              const SizedBox(height: Dimensions.paddingSizeLarge),


              /// HEADER
              Column(
                children: [
                  Image.network(
                    systemController.logoUrl,
                    height: 80,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    institute?.schoolName ?? 'Demo College',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    institute?.address ?? 'Dhaka',
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Tel: ${institute?.phone ?? ''} | EIIN: ${institute?.eiinCode ?? ''}',
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 2),
              const SizedBox(height: 16),

              /// DATE
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Date: ${AppConstants.currentDate}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 24),

              /// TITLE
              const Center(
                child: Text(
                  "STUDY CERTIFICATE",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// BODY
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  children: [
                    const TextSpan(text: 'This is to certify that '),

                    TextSpan(
                      text:
                      '${data?.studentSession?.student?.firstName ?? 'John'} ${data?.studentSession?.student?.lastName ?? 'Doe'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: ', son of '),

                    TextSpan(
                      text: data?.studentSession?.student?.fatherName ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: ' and '),

                    TextSpan(
                      text: data?.studentSession?.student?.motherName ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(
                        text:
                        ' is a bonafide student of this institution studying in '),

                    TextSpan(
                      text:
                      data?.studentSession?.classItem?.className ?? 'Class 12',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: ', '),

                    TextSpan(
                      text:
                      '${data?.studentSession?.student?.studentGroup?.groupName ?? 'Science'} Group',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: ' with Roll Number '),

                    TextSpan(
                      text: data?.studentSession?.roll ?? '123',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: ' for the academic session '),

                    TextSpan(
                      text:
                      data?.studentSession?.session?.year ?? '2024-2025',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const TextSpan(text: '.'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'He is a regular student and his conduct and character are satisfactory.',
                style: TextStyle(fontSize: 15, height: 1.6),
              ),

              const SizedBox(height: 24),

              const Text(
                'This certificate is issued for official purposes on his request.',
                style: TextStyle(fontSize: 15, height: 1.6),
              ),

              const SizedBox(height: 300),

              /// SIGNATURE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: ${AppConstants.currentDate}"),
                      Text("Place: ${institute?.address ?? 'Dhaka'}"),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "-----------------------------------",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Principal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(institute?.schoolName ?? ''),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}