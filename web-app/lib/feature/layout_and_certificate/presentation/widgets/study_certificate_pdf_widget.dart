import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StudyCertificatePrinter {
  static Future<void> printStudyCertificate() async {
    final pdf = pw.Document();

    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();

    final data = controller.layoutAndCertificateModel?.data;
    final institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [

              /// Header Center
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Image(logoImage, width: 100, height: 75),
                    pw.SizedBox(height: 16),

                    pw.Text(
                      institute?.schoolName ?? 'Demo College',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      institute?.address ?? 'Dhaka',
                      style: const pw.TextStyle(fontSize: 14),
                    ),

                    pw.Text(
                      'Tel: ${institute?.phone ?? ''} | EIIN: ${institute?.eiinCode ?? ''}',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 32),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 24),



              /// Title
              pw.Center(
                child: pw.Text(
                  'STUDY CERTIFICATE',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),

              pw.SizedBox(height: 32),

              /// Body
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(fontSize: 14, height: 1.5),
                  children: [
                    const pw.TextSpan(text: 'This is to certify that '),

                    pw.TextSpan(
                      text:
                      '${data?.studentSession?.student?.firstName ?? 'John'} ${data?.studentSession?.student?.lastName ?? 'Doe'}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: ', son of '),

                    pw.TextSpan(
                      text: data?.studentSession?.student?.fatherName ?? 'N/A',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: ' and '),

                    pw.TextSpan(
                      text: data?.studentSession?.student?.motherName ?? 'N/A',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(
                        text:
                        ' is a bonafide student of this institution studying in '),

                    pw.TextSpan(
                      text:
                      data?.studentSession?.classItem?.className ?? 'Class 12',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: ', '),

                    pw.TextSpan(
                      text:
                      '${data?.studentSession?.student?.studentGroup?.groupName ?? 'Science'} Group',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: ' with Roll Number '),

                    pw.TextSpan(
                      text: data?.studentSession?.roll ?? '123',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: ' for the academic session '),

                    pw.TextSpan(
                      text:
                      data?.studentSession?.session?.year ?? '2024-2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    const pw.TextSpan(text: '.'),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'He is a regular student and his conduct and character are satisfactory.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'This certificate is issued for official purposes on his request.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.Spacer(),

              /// Signature
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Date: ${AppConstants.currentDate}'),
                      pw.Text('Place: ${institute?.address ?? 'Dhaka'}'),
                    ],
                  ),

                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [

                      pw.SizedBox(height: 8),
                      pw.Text(
                        '--------------------------------------',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Principal',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(institute?.schoolName ?? 'Demo College'),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    /// ✅ DIRECT PRINT (NO PREVIEW)
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}