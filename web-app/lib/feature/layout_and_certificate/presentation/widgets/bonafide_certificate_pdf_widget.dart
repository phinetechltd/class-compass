import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BonafideCertificatePrinter {
  static Future<void> printCertificate() async {
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
          return pw.Container(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          institute?.schoolName ?? 'Demo School',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 16),
                        ),
                        pw.Text(institute?.address ?? 'Dhaka, Bangladesh'),
                        pw.Text('EIIN: ${institute?.eiinCode ?? ''}'),
                      ],
                    ),
                    pw.Image(logoImage, width: 80, height: 60),
                  ],
                ),
                pw.SizedBox(height: 24),
                // Date
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Date: ${AppConstants.currentDate}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 24),
                // Title
                pw.Center(
                  child: pw.Text(
                    'BONAFIDE CERTIFICATE',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                ),
                pw.SizedBox(height: 32),
                // Body
                pw.RichText(
                  text: pw.TextSpan(
                    style: const pw.TextStyle(fontSize: 12, height: 1.5),
                    children: [
                      const pw.TextSpan(text: 'This is to certify that '),
                      pw.TextSpan(
                        text:
                        '${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: ', son of '),
                      pw.TextSpan(
                        text: data?.studentSession?.student?.fatherName ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: ' and '),
                      pw.TextSpan(
                        text: data?.studentSession?.student?.motherName ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(
                          text:
                          ' is a bonafide student of this institution. He is currently studying in '),
                      pw.TextSpan(
                        text: data?.studentSession?.classItem?.className ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: ', '),
                      pw.TextSpan(
                        text:
                        '${data?.studentSession?.student?.studentGroup?.groupName ?? ''} Group',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: ' with Roll Number '),
                      pw.TextSpan(
                        text: data?.studentSession?.roll ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: ' for the academic session '),
                      pw.TextSpan(
                        text: data?.studentSession?.session?.year ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      const pw.TextSpan(text: '.'),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'He is a regular and disciplined student of this institution.',
                  style: const pw.TextStyle(fontSize: 12, height: 1.5),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'This certificate is issued on his request for official purposes.',
                  style: const pw.TextStyle(fontSize: 12, height: 1.5),
                ),
                pw.Spacer(),
                // Signature
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Sincerely', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 40),
                      pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Principal'),
                      pw.Text(institute?.schoolName ?? 'Demo School'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Open print dialog directly
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}