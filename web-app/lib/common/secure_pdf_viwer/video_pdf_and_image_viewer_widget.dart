import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:class_compass/common/video_section/universal_video_player.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'secure_pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class VideoPdfAndImageViewerWidget extends StatefulWidget {
  const VideoPdfAndImageViewerWidget({super.key});

  @override
  State<VideoPdfAndImageViewerWidget> createState() => _VideoPdfAndImageViewerWidgetState();
}

class _VideoPdfAndImageViewerWidgetState extends State<VideoPdfAndImageViewerWidget> {
  String? _viewId;
  String? _lastPdfUrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {
      final selectedContent = courseController.selectedContent;
      final videoType = selectedContent?.videoType;
      final width = courseController.videoWidth;
      final height = courseController.videoHeight;

      if (videoType == "document") {
        final pdfUrl = "${AppConstants.baseUrl}/storage/lessons/document_file/${selectedContent?.documentFile}";

        if (kIsWeb) {
          if (_viewId == null || _lastPdfUrl != pdfUrl) {
            _lastPdfUrl = pdfUrl;
            _viewId = 'pdf-view-${Random().nextInt(100000)}';
            registerSecurePdfViewer(_viewId!, pdfUrl);
          }
          return SizedBox(width: width, height: height, child: HtmlElementView(viewType: _viewId!));
        } else {
          return SizedBox(width: width, height: height, child: SfPdfViewer.network(pdfUrl));
        }
      }

      if (videoType == "image" || videoType == "none") {
        return SizedBox(width: width, height: height,
          child: CustomImage(image: "${AppConstants.baseUrl}/storage/lessons/${selectedContent?.thumbnailImage}"));
      }

      if (videoType == "upload") {
        return SizedBox(width: width, height: height,
          child: UniversalVideoPlayer(videoUrl: "${AppConstants.baseUrl}/storage/lessons/${selectedContent?.uploadedVideoPath ?? ""}"));
      }

      return SizedBox(width: width, height: height,
        child: UniversalVideoPlayer(videoUrl: selectedContent?.videoUrl ?? ""),
      );
    });
  }
}

