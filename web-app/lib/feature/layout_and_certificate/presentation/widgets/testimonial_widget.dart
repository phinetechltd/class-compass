import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/testimonial_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TestimonialWidget extends StatelessWidget {
  const TestimonialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: CustomContainer(verticalPadding: 50, horizontalPadding: 50,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

            Align(alignment: Alignment.centerRight,
              child: IntrinsicWidth(
                child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                  text: "Print", onTap: () {
                  TestimonialPrinter.printTestimonial();
                  }),
              )),
            const SizedBox(height: Dimensions.paddingSizeLarge),


            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(institute?.schoolName ?? '',
                    style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                Text(institute?.address ?? ''),
                Text("Tel: ${institute?.phone ?? ''}"),
                Text("EIIN: ${institute?.eiinCode ?? ''}"),
              ]),

              Image.network(systemController.logoUrl, height: 60),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(institute?.schoolName ?? '',
                    style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                Text(institute?.address ?? ''),
                Text("Tel: ${institute?.phone ?? ''}"),
                Text("EIIN: ${institute?.eiinCode ?? ''}"),
              ]),
            ]),

            const Divider(thickness: 2),

            Align(alignment: Alignment.centerRight,
              child: Text("Date: ${AppConstants.currentDate}",
                  style: textSemiBold.copyWith()),),
              const SizedBox(height: 20),

            Center(child: Text("Testimonial",
              style: textSemiBold.copyWith(
                  decoration: TextDecoration.underline, fontSize: Dimensions.fontSizeLarge),
            )),
            const SizedBox(height: 16),


            Text.rich(
              TextSpan(children: [
                   const TextSpan(text: 'This is to certify that '),
                TextSpan(text:
                '${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''}',
                    style: textSemiBold.copyWith()),
                const TextSpan(text: ' (Roll # '),

                TextSpan(text: '${data?.studentSession?.roll ?? 'N/A'})',
                    style: textSemiBold.copyWith()),

                const TextSpan(text: ', son of '),
                TextSpan(text: data?.studentSession?.student?.fatherName ?? 'N/A',
                    style: textSemiBold.copyWith(fontStyle: FontStyle.italic)),

                const TextSpan(text: ' and '),
                TextSpan(text: data?.studentSession?.student?.motherName ?? 'N/A',
                    style: textSemiBold.copyWith(fontStyle: FontStyle.italic)),

                TextSpan(text:
                        ', was a student of ${institute?.schoolName ?? 'N/A'} in ${data?.studentSession?.classItem?.className ?? 'N/A'} '
                            '${data?.studentSession?.student?.studentGroup?.groupName ?? 'N/A'} '
                            'from  ---------------------------- to  ----------------------------. '
                            'He appeared for the Higher Secondary Certificate Examinations of the ---------------------, '
                            'of Intermediate and Secondary Education in the year ---------------------------- '
                            'as a candidate from this college bearing Board Roll No ---------------------- '
                            'Registration No ------------------------ Session ----------------------- and '
                            'passed with GPA ---------------------------- on a scale of 5.00.'),
                  ]),
                style: const TextStyle(height: 1.5, fontSize: 12)),

              const SizedBox(height: 12),
              Text('His combination of Subjects was:----------------------------',
                style: textSemiBold.copyWith()),
              const SizedBox(height: 8),
              const Text(
                '........................................................................................................',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Text(
                'It is also certified that to the best of my knowledge he has a good moral character, '
                    'and while at this college he was not a source of indiscipline.',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 300),


              const Align(alignment: Alignment.centerRight,
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('Sincerely'),
                  SizedBox(height: 40),
                  Text('----------------------------'),
                  Text('Principal'),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}