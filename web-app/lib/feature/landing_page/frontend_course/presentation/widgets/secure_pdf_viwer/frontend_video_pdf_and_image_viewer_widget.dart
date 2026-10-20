import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/video_section/universal_video_player.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/secure_pdf_viwer/smooth_pdf_viwer.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'secure_pdf_viewer.dart';




class FrontendVideoPdfAndImageViewerWidget extends StatefulWidget {
  const FrontendVideoPdfAndImageViewerWidget({super.key});

  @override
  State<FrontendVideoPdfAndImageViewerWidget> createState() =>
      _FrontendVideoPdfAndImageViewerWidgetState();
}

class _FrontendVideoPdfAndImageViewerWidgetState
    extends State<FrontendVideoPdfAndImageViewerWidget> {
  String? _viewId;
  String? _lastPdfUrl;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendCourseController>(builder: (courseController) {
      final selectedContent = courseController.selectedContent;
      final videoType = selectedContent?.videoType;
      final width = isDesktop? courseController.videoWidth : MediaQuery.sizeOf(context).width;
      final height = isDesktop? courseController.videoHeight : MediaQuery.sizeOf(context).width;

      if (videoType == "document") {
        final pdfUrl = "${AppConstants.baseUrl}/storage/lessons/document_file/${selectedContent?.documentFile}";

        if (kIsWeb) {
          if (_viewId == null || _lastPdfUrl != pdfUrl) {
            _lastPdfUrl = pdfUrl;
            _viewId = 'pdf-view-${Random().nextInt(100000)}';
            registerSecurePdfViewer(_viewId!, pdfUrl);
          }

          return SizedBox(width: width, height: Get.height-300, child: HtmlElementView(viewType: _viewId!));
        } else {
          return SizedBox(width: width, height: Get.height - 300, child: SmoothPdfViewer(pdfUrl: pdfUrl));
        }
      }

      if (videoType == "image" || videoType == "none") {
        return SizedBox(width: width, height: height, child: CustomImage(
            image: "${AppConstants.baseUrl}/storage/lessons/${selectedContent?.thumbnailImage}"));
      }

      if (videoType == "upload") {
        return SizedBox(width: width, height: height, child: UniversalVideoPlayer(
            videoUrl: "${AppConstants.baseUrl}/storage/lessons/${selectedContent?.uploadedVideoPath ?? ""}"),);
      }

      return SizedBox(width: width, height: height, child: UniversalVideoPlayer(
          videoUrl: selectedContent?.videoUrl ?? ""));
    });
  }
}
