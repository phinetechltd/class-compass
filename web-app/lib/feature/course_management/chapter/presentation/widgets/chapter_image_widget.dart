import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/chapter/logic/chapter_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectChapterImageWidget extends StatelessWidget {
  const SelectChapterImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ChapterController>(
      builder: (chapterController) {
        return Align(alignment: Alignment.center, child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: chapterController.thumbnail != null ?  GetPlatform.isWeb? Image.network((chapterController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):Image.file(File(chapterController.thumbnail!.path),
                width: 150, height: 120, fit: BoxFit.cover,):
              const CustomImage(image: '', height: 120, width: 150)),


          Positioned(bottom: 0, right: 0, top: 0, left: 0,
              child: InkWell(onTap: () => chapterController.pickImage(),
                  child: Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      border: Border.all(width: 1, color: Theme.of(context).primaryColor)),
                      child: Container(margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white), shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, color: Colors.white)))))]));
      }
    );
  }
}
