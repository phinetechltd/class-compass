import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlAutoHeightPreview extends StatefulWidget {
  final String htmlContent;

  const HtmlAutoHeightPreview({super.key, required this.htmlContent});

  @override
  HtmlAutoHeightPreviewState createState() => HtmlAutoHeightPreviewState();
}

class HtmlAutoHeightPreviewState extends State<HtmlAutoHeightPreview> {
  final GlobalKey _htmlKey = GlobalKey();
  double _height = 10;

  @override
  void initState() {
    super.initState();
    // Measure after first build
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());
  }

  void _updateHeight() {
    final context = _htmlKey.currentContext;
    if (context == null) return;
    final renderBox = context.findRenderObject();
    if (renderBox is RenderBox && renderBox.hasSize) {
      final newHeight = renderBox.size.height;
      if ((_height - newHeight).abs() > 1) {
        setState(() {
          _height = newHeight;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant HtmlAutoHeightPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.htmlContent != widget.htmlContent) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Html(
        key: _htmlKey,
        data: widget.htmlContent,
      ),
    );
  }
}
