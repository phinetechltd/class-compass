
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';



class SelectSubjectWidget extends StatelessWidget {
  const SelectSubjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "subject"),
      GetBuilder<SubjectController>(builder: (subjectController) {
          final model = subjectController.subjectModel;
          List<SubjectItem> subject = model?.data?.data ?? [];

          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomGenericDropdown<SubjectItem>(
              title: "select_subject",
              items: subject,
              selectedValue: subjectController.selectedSubjectItem,
              onChanged: (val) {
                subjectController.setSelectSubjectItem(val!);
              },
              getLabel: (item) => item.subjectName ?? '',
            ),
          );
        },
      ),
    ],
    );
  }
}





class SelectSubjectTypeWidget extends StatelessWidget {
  const SelectSubjectTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "subject_type"),
      GetBuilder<SubjectController>(builder: (subjectController) {

        return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomGenericDropdown<String>(
            title: "select_subject_type",
            items: subjectController.subjectTypes,
            selectedValue: subjectController.selectedType,
            onChanged: (val) {
              subjectController.setSubjectType(val!);
            },
            getLabel: (item) => item,
          ),
        );
      },
      ),
    ],
    );
  }
}
