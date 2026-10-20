import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/gallery/gallery_full_screen_viwer.dart';

class GalleryImageTile extends StatefulWidget {
  final String imageUrl;
  final List<String> images;
  final int index;
  const GalleryImageTile({super.key, required this.imageUrl, required this.images, required this.index});

  @override
  State<GalleryImageTile> createState() => GalleryImageTileState();
}

class GalleryImageTileState extends State<GalleryImageTile> {
  double? _aspect;
  bool _isHover = false; // hover flag

  @override
  void initState() {
    super.initState();
    _resolveImageAspect();
  }

  void _resolveImageAspect() {
    final ImageStream stream = Image.network(widget.imageUrl).image.resolve(const ImageConfiguration());
    ImageStreamListener? listener;
    listener = ImageStreamListener((ImageInfo info, bool syncCall) {
      final w = info.image.width.toDouble();
      final h = info.image.height.toDouble();
      if (mounted) setState(() => _aspect = (h > 0 ? w / h : 1));
      stream.removeListener(listener!);
    }, onError: (Object error, StackTrace? stackTrace) {
      if (mounted) setState(() => _aspect = 1);
      stream.removeListener(listener!);
    });
    stream.addListener(listener);
  }

  void _openDialog() {
    final ctx = Get.context!;
    showGeneralDialog(
      context: ctx,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim, secondaryAnim) {
        return GalleryFullScreenViewer(images: widget.images, initialIndex: widget.index);
      },
      transitionBuilder: (context, anim, secondaryAnim, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return Transform.scale(scale: curved.value,
          child: Opacity(opacity: curved.value, child: child));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final aspect = _aspect ?? 1;

    return MouseRegion(cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(duration: const Duration(milliseconds: 300), curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _isHover ? -5 : 0, 0, 1)
          ..scaleByDouble(_isHover ? 1.03 : 1, _isHover ? 1.03 : 1, 1, 1),
        child: CustomContainer(onTap: _openDialog,
          horizontalPadding: 0, verticalPadding: 0,
          color: Theme.of(context).highlightColor,
          showShadow: _isHover,
          border: Border.all(color: Theme.of(context).highlightColor.withValues(alpha: .25),
            width: .25),
          child: ClipRRect(borderRadius: BorderRadius.circular(10),
            child: Hero(tag: widget.imageUrl,
              child: AspectRatio(aspectRatio: aspect,
                child: CustomImage(width: double.infinity, fit: BoxFit.cover,
                  image: widget.imageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
