import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/common/widget/custom_image.dart';

class ImagePreviewerWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final XFile? pickedFile;
  final String? title;

  const ImagePreviewerWidget({
    super.key,
    this.imageUrl,
    this.width = 150,
    this.height = 120,
    this.borderRadius = 8,
    this.pickedFile, this.title,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (pickedFile != null) {
      imageWidget = GetPlatform.isWeb ? Image.network(pickedFile!.path, width: width,
          height: height, fit: BoxFit.contain) :
      Image.file(File(pickedFile!.path), width: width, height: height, fit: BoxFit.contain);
    } else {
      imageWidget = CustomImage(image: imageUrl ?? "", height: height, width: width);
    }

    return ClipRRect(borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget);
  }
}
