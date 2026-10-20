import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:class_compass/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/controller/admit_and_seat_plan_controller.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/widgets/admit_card_item_widget.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/widgets/print_admit_card_widget.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/widgets/print_seat_plan_widget.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/widgets/seat_plan_item_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/util/dimensions.dart';


class AdmitAndSeatPlanWidget extends StatefulWidget {
  const AdmitAndSeatPlanWidget({super.key});

  @override
  State<AdmitAndSeatPlanWidget> createState() => _AdmitAndSeatPlanWidgetState();
}

class _AdmitAndSeatPlanWidgetState extends State<AdmitAndSeatPlanWidget> {
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdmitAndSeatPlanController>(
      builder: (admitCartAndSeatPlanController) {
        return Column(spacing: Dimensions.paddingSizeDefault, children: [

          SectionHeaderWithPath(sectionTitle: "routine_management".tr,
            pathItems: ["admit_and_seat_plan".tr],),
          const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomContainer(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: ExamSelectionWidget()),
                Expanded(child: SelectClassWidget()),
                Expanded(child: SelectSectionWidget()),

              ],),
            ),
          ),

          admitCartAndSeatPlanController.isLoading? const Center(child: CircularProgressIndicator()):
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
              const Spacer(),
              if (admitCartAndSeatPlanController.admitCardModel != null && admitCartAndSeatPlanController.admitCardModel?.data != null
                  && admitCartAndSeatPlanController.admitCardModel?.data?.data?.isNotEmpty == true)
              IntrinsicWidth(child: CustomButton(
                icon: const Icon(Icons.print_outlined, color: Colors.white),
                onTap: () async {
                  Get.dialog(
                    Dialog(
                      child: CustomContainer(verticalPadding: Dimensions.paddingSizeOverLarge,
                          child: Column(spacing: Dimensions.paddingSizeDefault,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          Text("please_wait_a_while_pdf_are_generating".tr),
                        ],
                      )),
                    ),
                    barrierDismissible: false,
                  );

                  try {
                    if(admitCartAndSeatPlanController.selectedType == 0) {
                      await AdmitCardPrinter.printAllAdmitCards(
                      admitCartAndSeatPlanController.admitCardModel?.data?.data ?? [],
                      admitCartAndSeatPlanController.admitCardModel?.data?.examName ?? 'N/A',
                    );
                    }else{
                      await SeatPlanPrinter.printAllSeatPlansThreePerPage(
                        admitCartAndSeatPlanController.admitCardModel?.data?.data ?? [],
                        admitCartAndSeatPlanController.admitCardModel?.data?.examName ?? 'N/A',
                      );
                    }
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  } finally {
                    if (Get.isDialogOpen!) Get.back();
                  }
                },
                text: "print".tr,
              )
              ),

              SizedBox(width: 100, child: CustomButton(onTap: (){
                int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                int? examId = Get.find<ExamController>().selectedExamItem?.id;
                int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                if(classId == null){
                  showCustomSnackBar("select_class".tr);
                }else if(examId == null){
                  showCustomSnackBar("select_exam".tr);
                }else if(sectionId == null){
                  showCustomSnackBar("select_section".tr);
                }else {
                  admitCartAndSeatPlanController.selectType(0);
                  admitCartAndSeatPlanController.getAdmitAndSeatPlan(classId, examId, sectionId, "admit_card");
                }
              }, text: "admit_card".tr)),

              SizedBox(width: 100, child: CustomButton(onTap: (){
                int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                int? examId = Get.find<ExamController>().selectedExamItem?.id;
                int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                if(classId == null){
                  showCustomSnackBar("select_class".tr);
                }else if(examId == null){
                  showCustomSnackBar("select_exam".tr);
                }else if(sectionId == null){
                  showCustomSnackBar("select_section".tr);
                }else {
                  admitCartAndSeatPlanController.selectType(1);
                  admitCartAndSeatPlanController.getAdmitAndSeatPlan(classId, examId, sectionId, "seat_plan");
                }
              }, text: "seat_plan".tr)),



            ],),
          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: GetBuilder<AdmitAndSeatPlanController>(
                  builder: (admitCartAndSeatPlanController) {
                    var admitAndSeat = admitCartAndSeatPlanController.admitCardModel?.data;
                    AdmitCardModel? admitCard = admitCartAndSeatPlanController.admitCardModel;
                    return  admitCard != null? (admitCard.data?.data!= null && admitCard.data!.data!.isNotEmpty)?
                    MasonryGridView.count(
                        itemCount: admitAndSeat?.data?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return admitCartAndSeatPlanController.selectedType == 0?
                          AdmitCardItemWidget(admitCardItem: admitAndSeat?.data?[index], index: index) :
                          SeatPlanItemWidget(admitCardItem: admitAndSeat?.data?[index], index: index);
                        }, crossAxisCount: admitCartAndSeatPlanController.selectedType == 0? 1: 2,
                        crossAxisSpacing: Dimensions.paddingSizeDefault,
                        mainAxisSpacing: Dimensions.paddingSizeDefault) :
                    Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
                      child: const Center(child: NoDataFound()),):

                    const SizedBox();
                  }
              ),
          ),

          ],
        );
      }
    );
  }
}
