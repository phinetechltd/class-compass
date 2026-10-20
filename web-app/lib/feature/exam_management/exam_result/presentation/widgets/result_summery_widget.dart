import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/exam_management/exam_result/controller/exam_result_controller.dart';
import 'package:class_compass/feature/exam_management/exam_result/domain/models/exam_result_model.dart';
import 'package:class_compass/feature/exam_management/marksheet/screens/mark_sheet_pdf.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:printing/printing.dart';

class ResultSummeryWidget extends StatelessWidget {
  const ResultSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamResultController>(builder: (resultController) {
      ExamResultModel? model = resultController.examResultModel;
      Summary? summery = model?.summary;
        return CustomContainer(child: Row(children: [
            Expanded(
              child: Column(spacing: Dimensions.paddingSizeSmall,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${"total_student".tr}: ${summery?.totalStudents}"),
                Text("${"passed".tr}: ${summery?.passed}"),
                Text("${"failed".tr}: ${summery?.failed}"),
              ]),
            ),
            SizedBox(width: 180,child: CustomButton(onTap: ()async {
              Get.dialog(ConfirmationDialog(action: true,
                  title: "do_you_want_to_generate_marksheet_for_all_students".tr,
                  content: "it_will_take_time_to_generate_pdf".tr,
                  onTap: () async {
                Get.back();
                await Printing.layoutPdf(
                  onLayout: (format) async => generateMarksheetPdfBytes(),
                );
              }));

            },
                text: "generate_marksheet".tr),),
          ],
        ));
      }
    );
  }
}
