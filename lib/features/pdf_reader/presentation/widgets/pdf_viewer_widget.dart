import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatelessWidget {
  final String filePath;
  final PdfViewerController controller;
  final int initialPageNumber;
  final ValueChanged<PdfPageChangedDetails> onPageChanged;

  const PdfViewerWidget({
    super.key,
    required this.filePath,
    required this.controller,
    required this.initialPageNumber,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SfPdfViewerTheme(
      data: const SfPdfViewerThemeData(backgroundColor: Colors.white),
      child: SfPdfViewer.file(
        File(filePath),
        controller: controller,
        initialPageNumber: initialPageNumber,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
