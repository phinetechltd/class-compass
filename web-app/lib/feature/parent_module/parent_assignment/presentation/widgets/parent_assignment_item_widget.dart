import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class ParentAssignmentItemWidget extends StatelessWidget {
  final AssignmentItem? assignmentItem;
  final int index;
  const ParentAssignmentItemWidget({super.key, this.assignmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(showShadow: false, borderRadius: Dimensions.paddingSizeSmall,
          borderColor: Theme.of(context).primaryColor, child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall,  children: [
                Text("${assignmentItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text("${assignmentItem?.subjectName??''} ${assignmentItem?.subjectCode??''}", style: textRegular.copyWith(),),
                Text("${"deadline".tr}: ${assignmentItem?.deadline??''}",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),),
              ]),
            ),
        ],
      )),
    );
  }
}