
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/exam_management/marksheet/controller/markaheet_controller.dart';
import 'package:class_compass/feature/exam_management/marksheet/widgets/image_previwer_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SampleMarksheetWidget extends StatelessWidget {
  const SampleMarksheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkSheetController>(builder: (markSheetController) {
        return CustomContainer(width: 600,height: (600 * 1.41)+20,
          child: Stack(children: [
            ImagePreviewerWidget(pickedFile: markSheetController.borderDesign,
              width: 600, imageUrl: "", height: (600 * 1.41)),



            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: .25,
                  child: ImagePreviewerWidget(
                    width: 100,
                    pickedFile: markSheetController.watermark,
                    imageUrl: "",
                  ),
                ),
              ),
            ),


            Positioned(top: 80,left: 0,right: 0,
              child: Center(child: Opacity(opacity: .25,
                  child: Column(
                    children: [
                      ImagePreviewerWidget(pickedFile: markSheetController.headerLogo,
                        height: 70, imageUrl: "",),
                      Text("exam_marksheet_of_student".tr,
                        style: textMedium.copyWith(
                            color: Colors.black,
                            fontSize: Dimensions.fontSizeLarge),)
                    ],
                  )),
              ),
            ),

            Positioned(bottom: 0,left: 0,right: 0,
              child: Padding(padding: const EdgeInsets.all(70),
                child: Center(child: Opacity(opacity: .25, child: Column(children: [
                  Row(spacing: Dimensions.paddingSizeDefault,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        CustomImage(width: 50,
                          image: "${AppConstants.imageBaseUrl}/signatures/${Get.find<SignatureController>().selectedSignatureItem?.image}",),

                         CustomImage(width: 50,
                          image: "${AppConstants.imageBaseUrl}/signatures/${Get.find<SignatureController>().selectedTeacherSignatureItem?.image}",),

                        ImagePreviewerWidget(pickedFile: markSheetController.stampImage,
                            width: 50, imageUrl: ""),
                      ]),
                  const SizedBox(height: 20)
                ])),
                ),
              ),
            ),


          ]),
        );
      }
    );
  }
}