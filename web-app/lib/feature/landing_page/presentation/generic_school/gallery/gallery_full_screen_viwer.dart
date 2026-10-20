import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';

class GalleryFullScreenViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const GalleryFullScreenViewer({super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<GalleryFullScreenViewer> createState() => GalleryFullScreenViewerState();
}

class GalleryFullScreenViewerState extends State<GalleryFullScreenViewer> {
  late final PageController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(type: MaterialType.transparency,
      child: SafeArea(
        child: Stack(children: [
          PageView.builder(controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final url = widget.images[i];
              return Center(
                child: Hero(tag: url,
                  child: InteractiveViewer(maxScale: 4, minScale: 1,
                      child: CustomContainer(borderRadius: 0, showShadow: false,
                          child: CustomImage(fit: BoxFit.contain, image: url))),
                ),
              );
            },
          ),
          Positioned(top: 8, right: 8,
              child: IconButton(icon: Icon(Icons.clear, color: Theme.of(context).hintColor, size: 30),
                  onPressed: () => Navigator.of(context).pop())),
          Positioned(bottom: 16, left: 0, right: 0,
            child: Center(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                child: DefaultTextStyle(style: const TextStyle(color: Colors.white, fontSize: 14),
                    child: Text('${_current + 1} / ${widget.images.length}'))),
            ),
          ),
        ],
        ),
      ),
    );
  }
}