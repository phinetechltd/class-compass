import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';

class SelectCourseCategoryImageWidget extends StatelessWidget {
  final String? image;
  const SelectCourseCategoryImageWidget({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CourseCategoryController>(
      builder: (courseCategoryController) {
        return InkWell(onTap: ()=> courseCategoryController.pickImage(),
          child: Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                child: courseCategoryController.thumbnail != null ?  GetPlatform.isWeb? Image.network((courseCategoryController.thumbnail!.path),
                  width: Dimensions.categoryImageSize, height: Dimensions.categoryImageSize, fit: BoxFit.cover,):Image.file(File(courseCategoryController.thumbnail!.path),
                  width: Dimensions.categoryImageSize, height: Dimensions.categoryImageSize, fit: BoxFit.cover,):
                 CustomImage(image: image, height: Dimensions.categoryImageSize, width: Dimensions.categoryImageSize, placeholder: Images.imagePickerIcon)),

          ]),
        );
      }
    );
  }
}
