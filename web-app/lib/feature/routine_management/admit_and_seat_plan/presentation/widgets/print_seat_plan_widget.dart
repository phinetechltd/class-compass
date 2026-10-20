import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/util/app_constants.dart';

class SeatPlanPrinter {
  static Future<void> printAllSeatPlansThreePerPage(List<AdmitCardItem> seatPlanList, String examName) async {
    final pdf = pw.Document();
    final systemController = Get.find<SystemSettingsController>();
    final logoImage = await loadNetworkImage(systemController.logoUrl);

    for (int i = 0; i < seatPlanList.length; i += 3) {
      final firstItem = seatPlanList[i];
      final secondItem = (i + 1 < seatPlanList.length) ? seatPlanList[i + 1] : null;
      final thirdItem = (i + 2 < seatPlanList.length) ? seatPlanList[i + 2] : null;

      final firstStudentImage = await loadNetworkImage("${AppConstants.imageBaseUrl}/users/${firstItem.student?.user?.image}");
      final secondStudentImage = secondItem != null
          ? await loadNetworkImage("${AppConstants.imageBaseUrl}/users/${secondItem.student?.user?.image}")
          : null;
      final thirdStudentImage = thirdItem != null
          ? await loadNetworkImage("${AppConstants.imageBaseUrl}/users/${thirdItem.student?.user?.image}")
          : null;

      pdf.addPage(
        pw.Page(margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(children: [
              _buildSeatPlanCard(firstItem, firstStudentImage, logoImage, examName),
              if (secondItem != null) pw.SizedBox(height: 20),
              if (secondItem != null) _buildSeatPlanCard(secondItem, secondStudentImage!, logoImage, examName),
              if (thirdItem != null) pw.SizedBox(height: 20),
              if (thirdItem != null) _buildSeatPlanCard(thirdItem, thirdStudentImage!, logoImage, examName),
            ]);
          },
        ),
      );
    }

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static pw.Widget _buildSeatPlanCard(AdmitCardItem item, pw.ImageProvider studentImage, pw.ImageProvider logoImage, String examName) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        // Header
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
          padding: const pw.EdgeInsets.all(8),
          child: pw.Row(children: [
            pw.Image(logoImage, height: 40),
            pw.Expanded(child: pw.Center(child: pw.Column(children: [
              pw.Text(AppConstants.appName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text("${item.classItem?.className ?? 'N/A'} ${item.section?.sectionName ?? 'N/A'}",
                  style: const pw.TextStyle(fontSize: 12)),
            ]))),
          ]),
        ),

        pw.SizedBox(height: 8),
        pw.Center(child: pw.Text("Seat Plan for $examName", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold))),
        pw.SizedBox(height: 8),

        // Student info row
        pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
          padding: const pw.EdgeInsets.all(8),
          child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              _infoRow("Roll", item.roll ?? ""),
              _infoRow("Name", "${item.student?.firstName ?? ""} ${item.student?.lastName ?? ""}"),
              _infoRow("Section", item.section?.sectionName ?? ""),
              _infoRow("Group", item.student?.studentGroup?.groupName ?? ""),
            ])),
            pw.Container(width: 80, height: 80, decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
                child: pw.Image(studentImage, fit: pw.BoxFit.cover)),
          ]),
        ),
      ]),
    );
  }

  static pw.Widget _infoRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Text("$title: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Expanded(child: pw.Text(value)),
      ]),
    );
  }
}
