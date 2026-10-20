import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';



class ParentSubjectItemWidget extends StatelessWidget {
  final SubjectItem? subject;
  const ParentSubjectItemWidget({super.key, this.subject});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      showShadow: false, borderRadius: 5, borderColor: Theme.of(context).primaryColor,
      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
      child: Padding(padding: const EdgeInsets.all(12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(subject?.subjectName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: .67, backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor), minHeight: 6),
            const SizedBox(height: 6),
            Text('${(.45 * 100).toInt()}%', style: textRegular),
          ])),
    );
  }
}
