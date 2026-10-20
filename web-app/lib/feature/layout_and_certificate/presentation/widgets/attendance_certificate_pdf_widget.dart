import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AttendanceCertificatePrinter {
  static Future<void> printAttendanceCertificate() async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32), // Outer margin for page
        build: (context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(24), // Padding inside the certificate
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Image(logoImage, width: 80, height: 80),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            institute?.schoolName ?? 'Demo College',
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            'Perfect Attendance',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 80),
                  ],
                ),

                pw.SizedBox(height: 32),

                // Student info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'Name: ',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                        pw.Container(
                          width: 200,
                          padding: const pw.EdgeInsets.only(bottom: 2),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(
                                color: PdfColors.black,
                                style: pw.BorderStyle.dotted,
                              ),
                            ),
                          ),
                          child: pw.Text(
                            '${data?.studentSession?.student?.firstName ?? 'John'} ${data?.studentSession?.student?.lastName ?? 'Doe'}',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          'Roll No: ',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                        pw.Container(
                          width: 100,
                          padding: const pw.EdgeInsets.only(bottom: 2),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(
                                color: PdfColors.black,
                                style: pw.BorderStyle.dotted,
                              ),
                            ),
                          ),
                          child: pw.Text(
                            data?.studentSession?.roll ?? '123',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 32),

                // Certificate body
                pw.Text(
                  'has completed two years course of study at ${institute?.schoolName ?? 'Demo College'} '
                      'with perfect attendance. We consider this to be a sign of his honesty, sincerity, responsibility, '
                      'hard work and strong determination to do well.',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontStyle: pw.FontStyle.italic,
                    height: 1.5,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),

                pw.SizedBox(height: 48),

                pw.Text(
                  'Congratulations.',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),

                pw.Spacer(),

                // Signature
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 16),
                      pw.Text(
                        '------------------------------',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Principal',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}