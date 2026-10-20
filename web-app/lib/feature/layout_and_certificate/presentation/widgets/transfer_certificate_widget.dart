import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/transfer_certificate_pdf_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TransferCertificateView extends StatelessWidget {
  const TransferCertificateView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutAndCertificateController>();
    final data = controller.layoutAndCertificateModel?.data;
    final systemController = Get.find<SystemSettingsController>();
    final institute = systemController.generalSettingModel?.data;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Align(alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: CustomButton(icon: const Icon(Icons.print_outlined, color: Colors.white),
                      text: "Print", onTap: () {
                        TransferCertificatePrinter.printTransferCertificate();
                      }),
                )),
            const SizedBox(height: Dimensions.paddingSizeLarge),


            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerInfo(institute),
                Image.network(systemController.logoUrl, height: 50),
                _headerInfo(institute, alignRight: true),
              ],
            ),

            const Divider(thickness: 1),

            /// DATE
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Date: ${AppConstants.currentDate}",
                style: textSemiBold,
              ),
            ),

            const SizedBox(height: 12),

            /// TITLE
            Center(
              child: Text(
                "TRANSFER CERTIFICATE",
                style: textSemiBold.copyWith(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// TABLE
            Table(
              border: TableBorder.all(color: Theme.of(context).hintColor),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _row("1. Name of Student",
                    "${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''}"),
                _row("2. Father's Name",
                    data?.studentSession?.student?.fatherName ?? ''),
                _row("3. Mother's Name",
                    data?.studentSession?.student?.motherName ?? ''),
                _row("4. Date of Birth",
                    data?.studentSession?.student?.birthday ?? ''),
                _row("5. Class",
                    data?.studentSession?.classItem?.className ?? ''),
                _row("6. Roll Number",
                    data?.studentSession?.roll ?? ''),
                _row("7. Registration Number",
                    data?.studentSession?.student?.registerNo?.toString() ?? ''),
                _row("8. Session",
                    data?.studentSession?.session?.year ?? ''),
                _row("9. Group",
                    data?.studentSession?.student?.studentGroup?.groupName ?? ''),
                _row("10. Date of Admission", ""),
                _row("11. Date of Leaving", ""),
                _row("12. Reason for Leaving", "Completion of Course"),
                _row("13. Character", "Good"),
                _row("14. Conduct", "Satisfactory"),
                _row("15. Last Exam Passed", ""),
                _row("16. Result", "Passed"),
              ],
            ),

            const SizedBox(height: 100),

            /// FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: ${AppConstants.currentDate}"),
                    const SizedBox(height: 6),
                    Text("Place: ${institute?.address ?? ''}"),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 8),
                    const Text("-----------------------------"),
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

  /// Header widget
  Widget _headerInfo(dynamic institute, {bool alignRight = false}) {
    return Column(
      crossAxisAlignment:
      alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(institute?.schoolName ?? '', style: textSemiBold),
        Text(institute?.address ?? ''),
        Text("Tel: ${institute?.phone ?? ''}"),
        Text(institute?.eiinCode ?? ''),
      ],
    );
  }

  /// Table row
  TableRow _row(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(title, style: textSemiBold),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(value),
        ),
      ],
    );
  }
}