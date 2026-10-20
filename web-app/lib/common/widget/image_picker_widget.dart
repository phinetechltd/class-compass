import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/styles.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final Color overlayColor;
  final IconData overlayIcon;
  final VoidCallback onImagePicked;
  final XFile? pickedFile;
  final String? title;
  final String? guide;

  const ImagePickerWidget({
    super.key,
    this.imageUrl,
    this.width = 150,
    this.height = 120,
    this.borderRadius = 8,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.3),
    this.overlayIcon = Icons.camera_alt,
    required this.onImagePicked,
    this.pickedFile,
    this.title, this.guide,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (pickedFile != null) {
      imageWidget = GetPlatform.isWeb ? Image.network(pickedFile!.path, width: width,
          height: height, fit: BoxFit.cover) :
      Image.file(File(pickedFile!.path), width: width, height: height, fit: BoxFit.cover);
    } else {
      imageWidget = CustomImage(image: imageUrl ?? "", height: height, width: width);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (title != null)
          Padding(padding: const EdgeInsets.only(bottom: 8.0), child: Text(title!,
              style: textRegular.copyWith())),

        Align(alignment: Alignment.center, child: Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(borderRadius),
              child: imageWidget),

             Positioned.fill(child: InkWell(onTap: onImagePicked,
                  child: Container(decoration: BoxDecoration(color: overlayColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(width: 1, color: systemPrimaryColor())),
                    child: Center(child: Container(padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white),shape: BoxShape.circle),
                        child: Icon(overlayIcon, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      if (guide != null)
        Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(guide!,
            style: textRegular.copyWith())),
      ],
    );
  }
}
