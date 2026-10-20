import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/util/app_constants.dart';

class AdmitCardPrinter {
  static Future<void> printAllAdmitCards(List<AdmitCardItem> admitCardList, String examName) async {
    final pdf = pw.Document();
    final systemController = Get.find<SystemSettingsController>();
    final logoImage = await loadNetworkImage(systemController.logoUrl);

    for (final admitCardItem in admitCardList) {
      final studentImage = await loadNetworkImage(
          "${AppConstants.imageBaseUrl}/users/${admitCardItem.student?.user?.image}");

      pdf.addPage(
        pw.Page(margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Container(
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                // Header
                pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                  pw.Image(logoImage, height: 50, width: 50),
                  pw.SizedBox(width: 12),
                  pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                    pw.Text(AppConstants.appName, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),),
                    pw.Text("${admitCardItem.classItem?.className ?? 'N/A'} ${admitCardItem.section?.sectionName ?? 'N/A'}",
                        style: const pw.TextStyle(fontSize: 12)),
                  ])),
                ]),
                pw.SizedBox(height: 16),

                pw.Center(child: pw.Text("Admit Card - $examName",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
                pw.Divider(),

                // Student info
                pw.SizedBox(height: 12),
                pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    _infoRow("Roll", admitCardItem.roll ?? 'N/A'),
                    _infoRow("Name", "${admitCardItem.student?.firstName ?? ''} ${admitCardItem.student?.lastName ?? ''}"),
                    _infoRow("Group", admitCardItem.student?.studentGroup?.groupName ?? 'N/A'),
                    _infoRow("Father's Name", admitCardItem.student?.fatherName ?? 'N/A'),
                    _infoRow("Mother's Name", admitCardItem.student?.motherName ?? 'N/A'),
                  ])),
                  pw.Container(width: 100, height: 100, decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300)),
                      child: pw.Image(studentImage, fit: pw.BoxFit.cover)),
                ],
                ),

                pw.SizedBox(height: 24),
                pw.Text("Instructions:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                pw.Bullet(text: "Examinee must enter the exam hall at least 15 minutes before the exam starts."),
                pw.Bullet(text: "No extra papers will be allowed except the admit and registration card."),
                pw.Bullet(text: "Examinee must carry all necessary essentials (pen, pencil, etc.)."),
                pw.Bullet(text: "Authority reserves the right to expel any examinee for unfair means."),

                pw.SizedBox(height: 40),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                  _signatureBox("Signature of Class Teacher"),
                  _signatureBox("Signature of Principal"),
                ]),
              ],
              ),
            );
          },
        ),
      );
    }

    // Trigger print dialog for all admit cards
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static pw.Widget _infoRow(String title, String value) {
    return pw.Padding(padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text("$title: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Expanded(child: pw.Text(value)),
      ]),
    );
  }

  static pw.Widget _signatureBox(String label) {
    return pw.Column(children: [
      pw.Container(width: 150, height: 1, color: PdfColors.black),
      pw.SizedBox(height: 4),
      pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
    ],
    );
  }
}
