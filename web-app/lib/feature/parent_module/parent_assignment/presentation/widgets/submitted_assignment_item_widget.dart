import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/parent_module/parent_assignment/domain/models/submited_assignment_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class SubmittedAssignmentItemWidget extends StatelessWidget {
  final SubmittedAssignmentItem? assignmentItem;
  final int index;
  const SubmittedAssignmentItemWidget({super.key, this.assignmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(showShadow: false, borderRadius: Dimensions.paddingSizeSmall,
          borderColor: Theme.of(context).primaryColor,borderWidth: .5,  child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall,  children: [
                Text("${assignmentItem?.assignmentTitle}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text(assignmentItem?.subjectName??'', style: textRegular.copyWith(),),
                Text("${"deadline".tr}: ${assignmentItem?.assignmentDeadline??''}",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),),
              ]),
            ),
        ],
      )),
    );
  }
}