import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/attendance_certificate_pdf_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AttendanceCertificateWidget extends StatelessWidget {
  const AttendanceCertificateWidget({super.key});

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
          verticalPadding: 50,
          horizontalPadding: 50,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
                    child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                        text: "Print", onTap: () {
                          AttendanceCertificatePrinter.printAttendanceCertificate();
                        }),
                  )),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(systemController.logoUrl, width: 120, height: 90),
                  Expanded(
                    child: Column(children: [
                        Text(
                          institute?.schoolName ?? 'Demo College',
                          style: textSemiBold.copyWith(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Perfect Attendance',
                          style: textSemiBold.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 120), // Balance layout
                ],
              ),

              const SizedBox(height: 40),

              // Student info
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Text('Name: ', style: textSemiBold.copyWith(
                      fontStyle: FontStyle.italic, fontSize: 14)),

                  Container(width: 200,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Theme.of(context).hintColor,
                            style: BorderStyle.solid))),
                    child: Text('${data?.studentSession?.student?.firstName ?? 'John'} ${data?.studentSession?.student?.lastName ?? 'Doe'}',
                      style: textRegular),
                  ),
                ]),
                  Row(
                    children: [
                      Text('Roll No: ',
                          style: textSemiBold.copyWith(
                              fontStyle: FontStyle.italic, fontSize: 14)),
                      Container(
                        width: 150, decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Theme.of(context).hintColor, style: BorderStyle.solid))),
                        child: Text(data?.studentSession?.roll ?? '123',
                          style: textRegular),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Certificate body
              Text(
                'has completed two years course of study at ${institute?.schoolName ?? 'Demo College'} '
                    'with perfect attendance. We consider this to be a sign of his honesty, sincerity, responsibility, '
                    'hard work and strong determination to do well.',
                style: textSemiBold.copyWith(
                    fontStyle: FontStyle.italic, fontSize: 14, height: 1.5),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 60),

              Text(
                'Congratulations.',
                style: textSemiBold.copyWith(
                    fontStyle: FontStyle.italic, fontSize: 14),
              ),

              const SizedBox(height: 300),

              // Signature
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Sincerely'),
                    const SizedBox(height: 40),
                    Text('------------------------------',
                        style: textSemiBold.copyWith(fontWeight: FontWeight.bold)),
                    Text('Principal',
                        style: textSemiBold.copyWith(fontSize: 12),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}