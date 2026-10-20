import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:class_compass/feature/exam_management/exam_result/controller/exam_result_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/exam_management/marksheet/controller/markaheet_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';

Future<Uint8List> generateMarksheetPdfBytes() async {
  final pdf = pw.Document();

  final controller = Get.find<MarkSheetController>();
  final resultController = Get.find<ExamResultController>();
  final systemController = Get.find<SystemSettingsController>();

  var institute = systemController.generalSettingModel?.data;
  var design = controller.selectedMarkSheetConfigItem;

  /// Student List
  final students = resultController.examResultModel?.data ?? [];
  String imageUrl = "${AppConstants.imageBaseUrl}/result_card_images";
  String signatureImageUrl = "${AppConstants.imageBaseUrl}/signatures";

  /// Load Images ONCE
  final border = await loadNetworkImage("$imageUrl/${design?.borderDesign}");
  final logo = await loadNetworkImage("$imageUrl/${design?.headerLogo}");
  final watermark = await loadNetworkImage("$imageUrl/${design?.watermark}");
  final stamp = await loadNetworkImage("$imageUrl/${design?.stampImage}");
  final signature = await loadNetworkImage("$signatureImageUrl/${design?.signatureImage}");
  final teacherSignature = await loadNetworkImage("$signatureImageUrl/${design?.teacherSignatureImage}");

  /// LOOP STUDENTS
  for (var student in students) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) {
          return pw.Stack(
            children: [

              /// Background
              pw.Positioned.fill(
                  child: pw.Container(color: PdfColors.white)),

              pw.Positioned.fill(
                  child: pw.Image(border, fit: pw.BoxFit.cover)),

              /// Watermark
              pw.Center(
                child: pw.Opacity(
                  opacity: 0.08,
                  child: pw.Image(watermark, width: 300),
                ),
              ),

              /// CONTENT
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(60, 60, 60, 80),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    /// HEADER
                    pw.Center(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            institute?.siteTitle ?? '',
                            style: pw.TextStyle(
                              fontSize: 26,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          safePdfImage(logo, width: 80),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            'Exam Marksheet of Student',
                            style: const pw.TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    /// STUDENT INFO
                    infoTable(student),

                    pw.SizedBox(height: 20),

                    /// SUBJECT TABLE
                    marksTable(student),

                    pw.SizedBox(height: 15),

                    /// RESULT SUMMARY
                    pw.Text('GRAND TOTAL : ${student.totalMarks ?? 0}'),
                    pw.Text('GPA : ${student.gpa ?? 0}'),
                    pw.Text('GRADE : ${student.grade ?? ''}'),
                    pw.Text('RESULT : ${student.status ?? ''}'),

                    pw.Spacer(),

                    /// SIGNATURE BLOCK
                    pw.Row(
                      mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                      children: [
                        signatureBlock(signature, 'Principal Signature'),
                        signatureBlock(
                            teacherSignature, 'Class Teacher Signature'),
                        signatureBlock(stamp, 'School Stamp'),
                      ],
                    ),

                    pw.SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  return pdf.save();
}

///////////////////////////
/// INFO TABLE
///////////////////////////

pw.Widget infoTable(student) {
  return pw.Table(
    border: pw.TableBorder.all(),
    columnWidths: {
      0: const pw.FlexColumnWidth(2),
      1: const pw.FlexColumnWidth(3),
    },
    children: [
      infoRow('Name', student.studentName ?? ''),
      infoRow('Roll Number', student.roll ?? ''),
      infoRow('Student ID', '${student.studentId ?? ''}'),
      infoRow('Status', student.status ?? ''),
    ],
  );
}

pw.TableRow infoRow(String k, String v) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(k,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(v),
      ),
    ],
  );
}

///////////////////////////
/// MARKS TABLE
///////////////////////////

pw.Widget marksTable(student) {
  List<pw.TableRow> rows = [];

  rows.add(marksHeader());

  for (var sub in student.subjects ?? []) {
    rows.add(
      pw.TableRow(
        children: [
          sub.subjectName ?? '',
          sub.totalMarks ?? '',
          sub.grade ?? '',
          sub.gradePoint ?? '',
        ]
            .map(
              (e) => pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(e.toString()),
          ),
        )
            .toList(),
      ),
    );
  }

  return pw.Table(
    border: pw.TableBorder.all(),
    children: rows,
  );
}

pw.TableRow marksHeader() {
  return pw.TableRow(
    decoration: const pw.BoxDecoration(color: PdfColors.grey300),
    children: ['Subject', 'Marks', 'Grade', 'Grade Point']
        .map(
          (e) => pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(
          e,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
      ),
    )
        .toList(),
  );
}

///////////////////////////
/// SIGNATURE BLOCK
///////////////////////////

pw.Widget signatureBlock(
    pw.ImageProvider? signature, String title) {
  return pw.Column(
    children: [
      safePdfImage(signature, width: 80, height: 60),
      pw.SizedBox(height: 5),
      pw.Text(title, style: const pw.TextStyle(fontSize: 10)),
    ],
  );
}

///////////////////////////
/// SAFE IMAGE
///////////////////////////

pw.Widget safePdfImage(
    pw.ImageProvider? image, {
      double? width,
      double? height,
      pw.BoxFit fit = pw.BoxFit.contain,
    }) {
  if (image == null) return pw.SizedBox();

  return pw.Image(
    image,
    width: width,
    height: height,
    fit: fit,
  );
}
