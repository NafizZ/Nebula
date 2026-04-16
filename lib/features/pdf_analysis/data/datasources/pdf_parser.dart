import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfParser {
  Future<String> extractText(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();

    return compute(_extractTextInIsolate, bytes);
  }
}

String _extractTextInIsolate(Uint8List bytes) {
  final document = PdfDocument(inputBytes: bytes);

  try {
    final extractor = PdfTextExtractor(document);
    final text = extractor.extractText();
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  } finally {
    document.dispose();
  }
}
