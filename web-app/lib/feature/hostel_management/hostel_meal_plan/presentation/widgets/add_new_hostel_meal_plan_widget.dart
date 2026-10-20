import 'package:flutter/material.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_body.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/logic/hostel_meal_plan_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/select_meal_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/select_student_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class AddNewHostelMealPlanWidget extends StatefulWidget {
  final HostelMealPlanItem? mealPlanItem;
  const AddNewHostelMealPlanWidget({super.key, this.mealPlanItem});

  @override
  State<AddNewHostelMealPlanWidget> createState() => _AddNewHostelMealPlanWidgetState();
}

class _AddNewHostelMealPlanWidgetState extends State<AddNewHostelMealPlanWidget> {
  @override
  Widget build(BuildContext context) {
    return Column( spacing: Dimensions.paddingSizeDefault, children: [
      const Row(spacing: Dimensions.paddingSizeDefault, children: [

        Expanded(child: SelectClassWidget()),
        Expanded(child: SelectSectionWidget()),

      ]),
      const Row(spacing: Dimensions.paddingSizeDefault, children: [


        Expanded(child: SelectStudentWidget()),
        Expanded(child: SelectMealWidget()),
        Expanded(child: DateSelectionWidget()),
      ]),



      GetBuilder<HostelMealPlanController>(builder: (mealPlanController) {
          return CustomButton(text: "confirm".tr, onTap: (){
            int? studentId = Get.find<StudentController>().selectedStudentItem?.id;
            int? mealId = Get.find<HostelMealsController>().selectedMealItem?.id;
            String date = Get.find<DatePickerController>().formatedDate;
            if(studentId == null){
              showCustomSnackBar("select_student".tr);
            }else if(mealId == null) {
              showCustomSnackBar("select_meal".tr);
            }
            else{
                HostelMealPlanBody mealPlanBody = HostelMealPlanBody(
                    studentId: studentId.toString(),
                    mealId: mealId.toString(),
                    date: date);
                if(widget.mealPlanItem != null){
                  mealPlanController.editHostelMealPlan(widget.mealPlanItem!.id!, mealPlanBody);
                }else {
                  mealPlanController.createHostelMealPlan(mealPlanBody);
                }
            }
          });
        }
      ),
    ],
    );
  }
}
