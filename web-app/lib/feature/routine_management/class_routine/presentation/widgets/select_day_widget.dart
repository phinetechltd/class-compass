import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectDayWidget extends StatefulWidget {
  const SelectDayWidget({super.key});

  @override
  State<SelectDayWidget> createState() => _SelectDayWidgetState();
}

class _SelectDayWidgetState extends State<SelectDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: Dimensions.paddingSizeDefault),
      const CustomTitle(title: "day"),
      GetBuilder<ClassRoutineController>(builder: (routineController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:  CustomGenericDropdown<String>(
            title: "select_day",
            items: routineController.days,
            selectedValue: routineController.selectedDay,
            onChanged: (val) {
              routineController.selectDay(val!);
            },
            getLabel: (item) => item,
          ),
        );
      }
      ),
    ],
    );
  }
}
