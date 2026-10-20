import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class VdoCipherCustomPlayer extends StatefulWidget {
  const VdoCipherCustomPlayer({super.key});


  @override
  VdoCipherCustomPlayerState createState() => VdoCipherCustomPlayerState();
}

class VdoCipherCustomPlayerState extends State<VdoCipherCustomPlayer> {
  VdoPlayerController? _controller;
  final double aspectRatio = 16/9;

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CourseController>(
      builder: (courseController) {
        return SizedBox(height: ResponsiveHelper.isDesktop(context)? courseController.videoHeight : Get.width,
          child: courseController.embedInfo != null?
          VdoPlayer(embedInfo: courseController.embedInfo!,
            onPlayerCreated: (controller) => _onPlayerCreated(controller),
            onFullscreenChange: (isFullscreen) {},
            onError: (vdoError) {},
          ):const Center(child: CircularProgressIndicator()),
        );
      }
    );
  }

  _onPlayerCreated(VdoPlayerController? controller) {
    setState(() {
      _controller = controller;
      _onEventChange(_controller);
    });
  }

  _onEventChange(VdoPlayerController? controller) {
    controller!.addListener(() {

    });
  }
}