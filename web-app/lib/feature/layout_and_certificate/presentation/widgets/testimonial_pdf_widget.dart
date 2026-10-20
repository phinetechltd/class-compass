import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:class_compass/util/app_constants.dart';

class TestimonialPrinter {
  static Future<void> printTestimonial() async {
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
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text("Tel: ${institute?.phone ?? ''}"),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(institute?.schoolName ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? ''),
                      pw.Text("Tel: ${institute?.phone ?? ''}"),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                ],
              ),
              pw.Divider(thickness: 2),
              pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Date: ${AppConstants.currentDate}')),
              pw.SizedBox(height: 16),

              // Title
              pw.Center(
                child: pw.Text(
                  'Testimonial',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline),
                ),
              ),
              pw.SizedBox(height: 16),

              // Body
              pw.Text(
                'This is to certify that ${data?.studentSession?.student?.firstName ?? ''} ${data?.studentSession?.student?.lastName ?? ''} '
                    '(Roll # ${data?.studentSession?.roll ?? 'N/A'}), son of ${data?.studentSession?.student?.fatherName ?? 'N/A'} '
                    'and ${data?.studentSession?.student?.motherName ?? 'N/A'}, was a student of ${institute?.schoolName ?? ''} in '
                    '${data?.studentSession?.classItem?.className ?? 'N/A'} '
                    '${data?.studentSession?.student?.studentGroup?.groupName ?? 'N/A'} '
                    'from  ---------------------------- to  ----------------------------. '
                    'He appeared for the Higher Secondary Certificate Examinations of the ---------------------, '
                    'of Intermediate and Secondary Education in the year ---------------------------- '
                    'as a candidate from this college bearing Board Roll No ---------------------- '
                    'Registration No ------------------------ Session ----------------------- and '
                    'passed with GPA ---------------------------- on a scale of 5.00.',
                style: const pw.TextStyle(fontSize: 11, height: 1.5),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'His combination of Subjects was:----------------------------',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text('........................................................................................................',
                  style: const pw.TextStyle(fontSize: 11)),
              pw.SizedBox(height: 16),
              pw.Text(
                'It is also certified that to the best of my knowledge he has a good moral character, '
                    'and while at this college he was not a source of indiscipline.',
                style: const pw.TextStyle(fontSize: 11),
              ),
              pw.Spacer(),

              // Signature
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Sincerely'),
                    pw.SizedBox(height: 40),
                    pw.Text('----------------------------'),
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

    // Directly open print dialog
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}