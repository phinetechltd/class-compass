import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ParentSyllabusItemWidget extends StatelessWidget {
  final SyllabusItem? syllabusItem;
  final int index;
  const ParentSyllabusItemWidget({super.key, this.syllabusItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${syllabusItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
             if(syllabusItem?.description != null)
              Text("${"details".tr} : ${syllabusItem?.description??''}", style: textRegular.copyWith(),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(children: [
                  const Icon(CupertinoIcons.doc),
                  Text(syllabusItem?.file??''),
                ],
              ),
            )
            ]),
          ),
        ],
      )),
    );
  }
}