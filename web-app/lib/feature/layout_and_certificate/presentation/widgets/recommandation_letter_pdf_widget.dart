import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:class_compass/util/app_constants.dart';

class RecommendationLetterPrinter {
  static Future<void> printRecommendationLetter() async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;
    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? '',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text("Tel: ${institute?.phone ?? ''}"),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? '',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text("Tel: ${institute?.phone ?? ''}"),
                    ],
                  ),
                ],
              ),
              pw.Divider(thickness: 2),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text("Date: ${AppConstants.currentDate}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  "TO WHOM IT MAY CONCERN",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline),
                ),
              ),
              pw.SizedBox(height: 24),
              // Body
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    const pw.TextSpan(text: 'This is to certify that '),
                    pw.TextSpan(
                      text:
                      '${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''} (Roll # ${data?.studentSession?.roll ?? '--'})',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' , son of '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.fatherName ?? '',
                      style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                    ),
                    const pw.TextSpan(text: ' and '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.motherName ?? '',
                      style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                    ),
                    pw.TextSpan(
                        text:
                        ' is a student of ${data?.studentSession?.classItem?.className} in '),
                    pw.TextSpan(
                      text: institute?.schoolName ?? '',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontStyle: pw.FontStyle.italic),
                    ),
                    const pw.TextSpan(text: '  Group: '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.studentGroup?.groupName ?? '',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontStyle: pw.FontStyle.italic),
                    ),
                  ],
                  style:
                  pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Text('Any assistance given to him will be highly appreciated.',
                  style:
                  pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),
             pw.Spacer(),
              // Footer / Signature
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Sincerely'),
                    pw.SizedBox(height: 32),
                    pw.Text('-----------------------------------------'),
                    pw.Text('Principal'),
                    pw.Text(institute?.schoolName ?? ''),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Open system print dialog
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}