import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HscRecommendationLetterPrinter {
  static Future<void> printRecommendationLetter() async {
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
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? 'N/A'),
                      pw.Text('Tel: ${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? 'N/A'),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? 'N/A'),
                      pw.Text('Tel: ${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? 'N/A'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 16),

              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Date: ${AppConstants.currentDate}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 32),

              pw.Center(
                child: pw.Text(
                  'TO WHOM IT MAY CONCERN',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),
              pw.SizedBox(height: 32),

              // Body
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    const pw.TextSpan(text: 'This is to certify that '),
                    pw.TextSpan(
                      text: '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'} (Roll # ${data?.studentSession?.roll ?? '--'})',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' , son of '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.fatherName ?? 'N/A',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' and '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.motherName ?? 'N/A',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' was a student of '),
                    pw.TextSpan(
                      text: institute?.schoolName ?? 'N/A',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' in '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.studentGroup?.groupName ?? 'Food Processing',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic),
                    ),
                    const pw.TextSpan(text: ' group in the session of '),
                    pw.TextSpan(
                      text: data?.studentSession?.session?.year ?? '2024-2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(
                      text: '. He appeared in the HSC Exam- under Board of Intermediate and Secondary Education, Asia, Dhaka bearing ',
                    ),
                    pw.TextSpan(
                      text: 'Roll: ${data?.studentSession?.roll ?? '--'}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: '. He passed and obtained on a scale of 5.00.'),
                  ],
                  style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'To the best of my knowledge he did not participate in any anti-state activity and/or anti-discipline of the College. He bears a good moral character.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(height: 24),

              pw.Text(
                'Any assistance given to him will be highly appreciated.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
              ),

              pw.Spacer(),

              // Signature Section
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Sincerely', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 40),
                    pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Principal'),
                    pw.Text(institute?.schoolName ?? 'N/A'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Directly open print dialog
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}