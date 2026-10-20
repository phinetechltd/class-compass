import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'dart:math';

Future<void> generateQuestionPaper(
    BuildContext context,
    List<QuestionItem> questions,
    QuestionController controller, {
      int columns = 2,
      PdfPageFormat? pageFormat, // optional custom page format
    }) async {
  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  final pdf = pw.Document();

  // Header info
  String schoolName = controller.schoolNameController.text.trim().isEmpty
      ? "Class Compass"
      : controller.schoolNameController.text.trim();
  String className = controller.classNameController.text.trim().isEmpty
      ? "HSC 1st Year"
      : controller.classNameController.text.trim();
  String examName = controller.examNameController.text.trim().isEmpty
      ? "Model Test Exam"
      : controller.examNameController.text.trim();
  String subjectName = controller.subjectNameController.text.trim().isEmpty
      ? "Physics 1st Paper"
      : controller.subjectNameController.text.trim();
  String mark = controller.markController.text.trim().isEmpty
      ? "Marks: 100"
      : controller.markController.text.trim();
  String time = controller.timeController.text.trim().isEmpty
      ? "Time: 60 min"
      : controller.timeController.text.trim();

  final int columnCount = max(1, min(columns, 2)); // allow 1 or 2 columns

  // Use provided pageFormat or default to A4
  final PdfPageFormat format = pageFormat ?? PdfPageFormat.a4;

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(20),
      build: (context) {
        final tableWidth = format.availableWidth * 0.95; // 95% of printable width

        return [
          // Header
          pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  schoolName,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(className, textAlign: pw.TextAlign.center),
                pw.Text(examName, textAlign: pw.TextAlign.center),
                pw.Text(subjectName, textAlign: pw.TextAlign.center),
                pw.Text(mark, textAlign: pw.TextAlign.center),
                pw.Text(time, textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 20),
              ],
            ),
          ),

          // Questions Table
          pw.Center(
            child: pw.Container(
              width: tableWidth,
              child: pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
                columnWidths: Map.fromIterable(
                  List.generate(columnCount, (i) => i),
                  value: (_) => const pw.FlexColumnWidth(1),
                ),
                children: List<pw.TableRow>.generate(
                  (questions.length / columnCount).ceil(),
                      (rowIndex) {
                    return pw.TableRow(
                      children: List.generate(columnCount, (colIndex) {
                        final questionIndex = rowIndex * columnCount + colIndex;
                        if (questionIndex >= questions.length) return pw.Container();

                        final q = questions[questionIndex];

                        return pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "${questionIndex + 1}. ${q.question}",
                                style:  pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              if (q.options != null && q.options!.isNotEmpty)
                                ...List.generate(q.options!.length, (optIndex) {
                                  final option = q.options![optIndex];
                                  return pw.Text(
                                    "${String.fromCharCode(65 + optIndex)}) $option",
                                    style: const pw.TextStyle(fontSize: 10),
                                  );
                                }),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ),
        ];
      },
    ),
  );

  Navigator.pop(context); // close loading dialog

  // Print / preview PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
