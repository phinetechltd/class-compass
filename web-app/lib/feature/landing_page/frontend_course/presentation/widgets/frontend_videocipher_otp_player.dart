import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class FrontendVdoCipherCustomPlayer extends StatefulWidget {
  const FrontendVdoCipherCustomPlayer({super.key});

  @override
  State<FrontendVdoCipherCustomPlayer> createState() => _FrontendVdoCipherCustomPlayerState();
}

class _FrontendVdoCipherCustomPlayerState extends State<FrontendVdoCipherCustomPlayer> {
  VdoPlayerController? _mobileWebVdoController;

  @override
  void dispose() {
    _mobileWebVdoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(builder: (courseController) {
      final isDesktop = ResponsiveHelper.isDesktop(context);
      final height = isDesktop ? courseController.videoHeight : Get.width;

      return SizedBox(
        height: height,
        width: double.infinity,
        child: courseController.embedInfo == null
            ? const Center(child: CircularProgressIndicator())
            : _buildPlatformPlayer(courseController),
      );
    });
  }

  Widget _buildPlatformPlayer(FrontendCourseController courseController) {
    final embedInfo = courseController.embedInfo!;

    // ✅ Use official player on Android/iOS/Web
    if (kIsWeb ||
        (!kIsWeb && (Platform.isAndroid || Platform.isIOS))) {
      return VdoPlayer(
        embedInfo: embedInfo,
        onPlayerCreated: _onVdoPlayerCreated,
        onFullscreenChange: (isFs) {},
        onError: (err) => debugPrint('VdoCipher Error: $err'),
      );
    }

    // ✅ macOS / Windows fallback → launch in default browser
    if (!kIsWeb && (Platform.isMacOS || Platform.isWindows)) {
      return Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.open_in_browser),
          label: const Text("Open Video in Browser"),
          onPressed: () => _launchInBrowser(embedInfo),
        ),
      );
    }

    // If we reach here (e.g., Linux), show a helpful message
    return const Center(
      child: Text(
        'This platform is not supported by the native VdoCipher plugin.\n'
            'Consider a WebView or external browser fallback for Linux.',
        textAlign: TextAlign.center,
      ),
    );
  }

  void _onVdoPlayerCreated(VdoPlayerController controller) {
    _mobileWebVdoController = controller;

    controller.addListener(() {
      final v = controller.value;
      debugPrint(
        'VdoCipher => loading:${v.isLoading} '
            'playing:${v.isPlaying} buffering:${v.isBuffering} ended:${v.isEnded}',
      );
    });
  }

  String _buildIFrameUrl(EmbedInfo embedInfo) {
    final otp = Uri.encodeComponent(embedInfo.otp ?? '');
    final playbackInfo = Uri.encodeComponent(embedInfo.playbackInfo ?? '');
    return 'https://player.vdocipher.com/v2/?otp=$otp&playbackInfo=$playbackInfo';
  }

  Future<void> _launchInBrowser(EmbedInfo embedInfo) async {
    final url = _buildIFrameUrl(embedInfo);
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}