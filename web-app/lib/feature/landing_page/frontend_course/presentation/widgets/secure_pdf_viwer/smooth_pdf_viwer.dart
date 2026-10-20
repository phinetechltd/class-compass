import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class SmoothPdfViewer extends StatefulWidget {
  final String pdfUrl;
  const SmoothPdfViewer({super.key, required this.pdfUrl});

  @override
  State<SmoothPdfViewer> createState() => _SmoothPdfViewerState();
}

class _SmoothPdfViewerState extends State<SmoothPdfViewer> {
  PdfController? _pdfController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfFromUrl();
  }

  Future<void> _loadPdfFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final data = response.bodyBytes;
        _pdfController = PdfController(
          document: PdfDocument.openData(data),
        );
      } else {
        debugPrint('Failed to load PDF: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error loading PDF: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _pdfController == null
          ? const Center(child: Text('Failed to load PDF'))
          : PdfView(
        controller: _pdfController!,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
