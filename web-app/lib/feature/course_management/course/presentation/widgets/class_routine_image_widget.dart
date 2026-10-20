import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class ClassRoutineImage extends StatelessWidget {
  const ClassRoutineImage({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CourseController>(
        builder: (courseController) {
          return Align(alignment: Alignment.center, child: Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                child: courseController.parentIdProofImage != null ?  GetPlatform.isWeb? Image.network((courseController.parentIdProofImage!.path),
                  width: 150, height: 120, fit: BoxFit.cover,): Image.file(File(courseController.parentIdProofImage!.path),
                  width: 150, height: 120, fit: BoxFit.cover,) :
                const CustomImage(image: '', height: 120, width: 150)),

            Positioned(bottom: 0, right: 0, top: 0, left: 0,
                child: InkWell(onTap: () => courseController.pickImage(parentIdProof: true),
                    child: Container(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        border: Border.all(width: 1, color: systemPrimaryColor())),
                        child: Container(margin: const EdgeInsets.all(25),
                            decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white), shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, color: Colors.white)))))]));
        }
    );
  }
}
