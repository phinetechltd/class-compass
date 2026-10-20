import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

Future<pw.ImageProvider> loadNetworkImage(String? url) async {
  try {
    if (url == null || url.isEmpty) {
      return pw.MemoryImage(Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))));
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final contentType = response.headers['content-type'];
      Uint8List imageBytes = response.bodyBytes;
      if (contentType != null && !contentType.contains('png') && !contentType.contains('jpeg') && !contentType.contains('jpg')) {
        final decoded = img.decodeImage(imageBytes);
        if (decoded != null) {
          imageBytes = Uint8List.fromList(img.encodePng(decoded));
        } else {
          return pw.MemoryImage(Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))));
        }
      }
      return pw.MemoryImage(imageBytes);
    } else {
      return pw.MemoryImage(Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))));
    }
  } catch (e) {
    return pw.MemoryImage(Uint8List.fromList(img.encodePng(img.Image(width: 1, height: 1))));
  }
}
