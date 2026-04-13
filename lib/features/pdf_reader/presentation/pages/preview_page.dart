import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_analysis/presentation/pages/analyze_pdf.dart';
import 'package:nebula/features/pdf_reader/presentation/cubit/pdf_reader_cubit.dart';
import 'package:nebula/features/pdf_reader/presentation/cubit/pdf_reader_state.dart';
import 'package:nebula/features/pdf_reader/presentation/widgets/pdf_viewer_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.filePath});

  final String filePath;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late PdfViewerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
    context.read<PdfReaderCubit>().loadLastPage(widget.filePath);
  }

  @override
  void didUpdateWidget(PreviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filePath != widget.filePath) {
      _controller.dispose();
      _controller = PdfViewerController();
      context.read<PdfReaderCubit>().loadLastPage(widget.filePath);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(File(widget.filePath).uri.pathSegments.last),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnalyzePdf(filePath: widget.filePath),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: BlocBuilder<PdfReaderCubit, PdfReaderState>(
        builder: (context, state) {
          if (state.filePath == widget.filePath &&
              state.status == PdfReaderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final currentLastPage = state.filePath == widget.filePath
              ? state.lastPage
              : 1;

          return PdfViewerWidget(
            filePath: widget.filePath,
            controller: _controller,
            initialPageNumber: currentLastPage,
            onPageChanged: (details) {
              context.read<PdfReaderCubit>().saveLastPage(
                widget.filePath,
                details.newPageNumber,
              );
            },
          );
        },
      ),
    );
  }
}
