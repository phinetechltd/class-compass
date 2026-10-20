import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/migration_certificate_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MigrationCertificateWidget extends StatelessWidget {
  const MigrationCertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return Padding(padding: const EdgeInsets.all(24.0),
      child: CustomContainer(horizontalPadding: Dimensions.paddingSizeLarge,
        verticalPadding: Dimensions.paddingSizeLarge,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Align(alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                      text: "Print", onTap: () async {
                        await MigrationCertificatePrinter.printMigrationCertificate();
                      }),
                )),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institute?.schoolName ?? '', style: textSemiBold),
                    Text(institute?.address ?? ''),
                    Text('Tel: ${institute?.phone ?? ''}'),
                    Text(institute?.eiinCode ?? ''),
                  ],
                ),
                CustomImage(
                  image: systemController.logoUrl,
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(institute?.schoolName ?? '', style: textSemiBold),
                    Text(institute?.address ?? ''),
                    Text('Tel: ${institute?.phone ?? ''}'),
                    Text(institute?.eiinCode ?? ''),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Date: ${AppConstants.currentDate}', style: textRegular),
            ),
            const SizedBox(height: 16),

            // Title
            Center(
              child: Text(
                'MIGRATION CERTIFICATE',
                style: textSemiBold.copyWith(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Body
            Text(
              'This is to certify that ${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''} '
                  '(Roll # ${data?.studentSession?.roll ?? 'N/A'}), son of ${data?.studentSession?.student?.fatherName ?? 'N/A'} '
                  'and ${data?.studentSession?.student?.motherName ?? 'N/A'}, was a student of ${institute?.schoolName ?? ''} in '
                  '${data?.studentSession?.classItem?.className ?? 'N/A'} '
                  '${data?.studentSession?.student?.studentGroup?.groupName ?? 'N/A'} '
                  'from ---------------------------- to ----------------------------. '
                  'He appeared for the examinations and passed successfully.',
              style: textRegular.copyWith(height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'It is also certified that to the best of my knowledge he has a good moral character, '
                  'and while at this college he was not a source of indiscipline.',
              style: textRegular,
            ),
            const SizedBox(height: 300),

            // Signature
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Sincerely'),
                  const SizedBox(height: 40),
                  const Text('----------------------------'),
                  const Text('Principal', style: TextStyle(fontWeight: FontWeight.bold)),
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