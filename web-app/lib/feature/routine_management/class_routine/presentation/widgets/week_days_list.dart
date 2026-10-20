
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class WeekDaysList extends StatelessWidget {
  const WeekDaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoutineController>(
      builder: (routineController) {
        return Container(height: 60,decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: routineController.days.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  String day = routineController.days[index];
                  return Padding(padding: const EdgeInsets.fromLTRB(2,10,10,10),
                    child: CustomContainer(onTap: ()=>  routineController.selectDay(day),
                        color: day == routineController.selectedDay? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        horizontalPadding: ResponsiveHelper.isDesktop(context)? 20 : 10,
                        borderRadius: Dimensions.paddingSizeExtraSmall, child: Text(day, style: textMedium.copyWith(),)),
                  );
                }),
          ),
        );
      }
    );
  }
}
