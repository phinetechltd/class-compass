// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui;
import 'package:universal_html/html.dart' as html;

/// Registers an iframe as a platform view on Flutter Web
void registerSecurePdfViewer(String viewId, String pdfUrl) {
  ui.platformViewRegistry.registerViewFactory(viewId, (int _) {
    final iframe = html.IFrameElement()
      ..src = "/pdf_viewer.html?file=$pdfUrl"
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.overflow = 'hidden';

    return iframe;
  });
}
