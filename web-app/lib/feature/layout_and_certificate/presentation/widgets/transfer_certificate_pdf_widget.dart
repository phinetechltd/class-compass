import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransferCertificatePrinter {
  static Future<void> printTransferCertificate() async {
    final pdf = pw.Document();

    final controller = Get.find<LayoutAndCertificateController>();
    final data = controller.layoutAndCertificateModel?.data;
    final systemController = Get.find<SystemSettingsController>();
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              /// Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? '',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text('Tel:${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 40),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(institute?.schoolName ?? '',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text('Tel:${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                ],
              ),

              pw.Divider(),

              /// Date
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Date: ${AppConstants.currentDate}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),

              pw.SizedBox(height: 10),

              /// Title
              pw.Center(
                child: pw.Text(
                  'TRANSFER CERTIFICATE',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),

              pw.SizedBox(height: 10),

              /// Table
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  _buildRow('1. Name of Student:',
                      '${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''}'),
                  _buildRow('2. Father\'s Name:',
                      data?.studentSession?.student?.fatherName ?? ''),
                  _buildRow('3. Mother\'s Name:',
                      data?.studentSession?.student?.motherName ?? ''),
                  _buildRow('4. Date of Birth:',
                      data?.studentSession?.student?.birthday ?? ''),
                  _buildRow('5. Class:',
                      data?.studentSession?.classItem?.className ?? ''),
                  _buildRow('6. Roll Number:',
                      data?.studentSession?.roll ?? ''),
                  _buildRow('7. Registration Number:',
                      data?.studentSession?.student?.registerNo?.toString() ?? ''),
                  _buildRow('8. Session:',
                      data?.studentSession?.session?.year ?? ''),
                  _buildRow('9. Group:',
                      data?.studentSession?.student?.studentGroup?.groupName ?? ''),
                  _buildRow('10. Date of Admission:', ''),
                  _buildRow('11. Date of Leaving:', ''),
                  _buildRow('12. Reason for Leaving:', 'Completion of Course'),
                  _buildRow('13. Character:', 'Good'),
                  _buildRow('14. Conduct:', 'Satisfactory'),
                  _buildRow('15. Last Exam Passed:', ''),
                  _buildRow('16. Result:', 'Passed'),
                ],
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
                      pw.Text('Place: ${institute?.address ?? ''}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [

                      pw.SizedBox(height: 8),
                      pw.Text('-----------------------------',
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

  static pw.TableRow _buildRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value),
        ),
      ],
    );
  }
}