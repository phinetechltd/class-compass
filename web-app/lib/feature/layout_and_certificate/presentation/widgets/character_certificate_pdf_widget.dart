import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CharacterCertificatePrinter {
  static Future<void> printCharacterCertificate() async {
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
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [

              /// HEADER
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        institute?.schoolName ?? '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(institute?.address ?? ''),
                      pw.Text('Tel:${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 60),
                ],
              ),

              pw.SizedBox(height: 24),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 24),

              /// DATE
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Date: ${AppConstants.currentDate}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),

              pw.SizedBox(height: 32),

              /// TITLE
              pw.Center(
                child: pw.Text(
                  'CHARACTER CERTIFICATE',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),

              pw.SizedBox(height: 32),

              /// BODY
              pw.RichText(
                text: pw.TextSpan(
                  style: const pw.TextStyle(fontSize: 14, height: 1.5),
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
                    const pw.TextSpan(text: ' was a student of this institution from '),
                    pw.TextSpan(
                      text: data?.studentSession?.session?.year ?? '',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' to '),
                    pw.TextSpan(
                      text: '30/06/2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' in '),
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
                    const pw.TextSpan(text: '.'),
                  ],
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'During his stay in this institution, his character and conduct were found to be good and satisfactory. He was regular in attendance and showed keen interest in his studies.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'I wish him all success in his future endeavors.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.Spacer(),

              /// SIGNATURE
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Date: ${AppConstants.currentDate}'),
                      pw.Text('Place: ${institute?.address ?? ''}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [

                      pw.SizedBox(height: 8),
                      pw.Text('------------------------------',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Principal',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.schoolName ?? ''),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}