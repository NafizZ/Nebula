import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfParser {
  Future<String> extractText(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();

    final document = PdfDocument(inputBytes: bytes);
    final extractor = PdfTextExtractor(document);

    var text = extractor.extractText();
    document.dispose();

    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();

    return text;
  }
}
