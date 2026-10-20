import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/hsc_recommendation_letter_pdf_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class HscRecommendationLetterWidget extends StatelessWidget {
  const HscRecommendationLetterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Align(alignment: Alignment.centerRight,
              child: IntrinsicWidth(
                child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                    text: "Print", onTap: () {
                      HscRecommendationLetterPrinter.printRecommendationLetter();
                    }),
              )),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institute?.schoolName ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(institute?.address ?? 'N/A'),
                  Text('Tel: ${institute?.phone ?? ''}'),
                  Text(institute?.eiinCode ?? 'N/A'),
                ],
              ),
              CustomImage(image: systemController.logoUrl,height: 80,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institute?.schoolName ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(institute?.address ?? 'N/A'),
                  Text('Tel: ${institute?.phone ?? ''}'),
                  Text(institute?.eiinCode ?? 'N/A'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(thickness: 2),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Date: ${DateTime.now().toString().split(' ')[0]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),

          const Center(
            child: Text(
              'TO WHOM IT MAY CONCERN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Body
          RichText(
            text: TextSpan(
              style: textRegular.copyWith(fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.displayMedium?.color),
              children: [
                const TextSpan(text: 'This is to certify that '),
                TextSpan(
                  text:
                  '${data?.studentSession?.student?.firstName ?? 'Darrion'} '
                      '${data?.studentSession?.student?.lastName ?? 'Kassulke'} (Roll # '
                      '${data?.studentSession?.roll ?? '--'})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' , son of '),
                TextSpan(
                  text: data?.studentSession?.student?.fatherName ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: data?.studentSession?.student?.motherName ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' was a student of '),
                TextSpan(
                  text: institute?.schoolName ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' in '),
                TextSpan(
                  text: data?.studentSession?.student?.studentGroup?.groupName ?? 'Food Processing',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                const TextSpan(text: ' group in the session of '),
                TextSpan(
                  text: data?.studentSession?.session?.year ?? '2024-2025',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                    text:
                    '. He appeared in the HSC Exam- under Board of Intermediate and Secondary Education, Asia, Dhaka bearing '),
                TextSpan(
                  text: 'Roll: ${data?.studentSession?.roll ?? '--'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '. He passed and obtained on a scale of 5.00.'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'To the best of my knowledge he did not participate in any anti-state activity and/or anti-discipline of the College. He bears a good moral character.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),

          const Text(
            'Any assistance given to him will be highly appreciated.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),

          const SizedBox(height: 300),

          // Signature
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Sincerely', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),

                const Text('------------------------------', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('Principal'),
                Text(institute?.schoolName ?? 'N/A'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}