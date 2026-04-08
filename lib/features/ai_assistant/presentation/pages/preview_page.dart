import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.filePath});
  final String filePath;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filePath.split('/').last),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              icon: Icon(Icons.auto_awesome, color: Colors.white),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SfPdfViewerTheme(
          data: SfPdfViewerThemeData(backgroundColor: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SfPdfViewer.file(
              File(widget.filePath),
              pageLayoutMode: PdfPageLayoutMode.single,
              enableDoubleTapZooming: true,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              canShowPaginationDialog: true,
              scrollDirection: PdfScrollDirection.vertical,
            ),
          ),
        ),
      ),
    );
  }
}
