import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/chapter/logic/chapter_controller.dart';
import 'package:class_compass/feature/course_management/chapter/presentation/widgets/chapter_dropdown.dart';

class SelectChapterWidget extends StatefulWidget {
  const SelectChapterWidget({super.key});

  @override
  State<SelectChapterWidget> createState() => _SelectChapterWidgetState();
}

class _SelectChapterWidgetState extends State<SelectChapterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "chapter"),
      GetBuilder<ChapterController>(
        initState: (val){
          if(Get.find<ChapterController>().chapterModel == null){
            Get.find<ChapterController>().getChapter(1);
          }
        },
          builder: (chapterController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ChapterDropdown(width: Get.width, title: "select".tr,
                items: chapterController.chapterModel?.data?.data??[],
                selectedValue:  chapterController.selectedChapterItem,
                onChanged: (val){
                chapterController.setSelectChapterItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
