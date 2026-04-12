import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/ai_assistant/presentation/pages/analyze_pdf.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.filePath});
  final String filePath;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late PdfViewerController _controller;

  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
    _loadPdfData();
  }

  @override
  void didUpdateWidget(PreviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the file path changed, reinitialize the controller and load new PDF data
    if (oldWidget.filePath != widget.filePath) {
      _controller.dispose();
      _controller = PdfViewerController();
      _loadPdfData();
    }
  }

  void _loadPdfData() {
    final pdf = context.read<PdfCubit>().getPdfByPath(widget.filePath);
    lastPage = pdf?.lastPage ?? 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pdf = context.read<PdfCubit>().getPdfByPath(widget.filePath);
    final currentLastPage = pdf?.lastPage ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filePath.split('/').last),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              icon: Icon(Icons.auto_awesome, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalyzePdf()),
                );
              },
            ),
          ),
          SizedBox(width: 12),
        ],
      ),

      body: SfPdfViewerTheme(
        data: const SfPdfViewerThemeData(backgroundColor: Colors.white),

        child: SfPdfViewer.file(
          File(widget.filePath),
          key: ValueKey(
            widget.filePath,
          ), // Force widget rebuild when file changes
          controller: _controller,
          initialPageNumber: currentLastPage,

          onPageChanged: (details) {
            if (pdf?.id != null) {
              context.read<PdfCubit>().updateLastPage(
                pdf!.id!,
                details.newPageNumber,
              );
            }
          },
        ),
      ),
    );
  }
}
