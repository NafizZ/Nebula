import 'dart:async';
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
  late PdfReaderCubit _cubit;

  Timer? _debounce;

  bool _initialized = false;
  int _initialPage = 1;

  @override
  void initState() {
    super.initState();

    _controller = PdfViewerController();
    _cubit = context.read<PdfReaderCubit>();

    _cubit.loadLastPage(widget.filePath);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(PdfPageChangedDetails details) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _cubit.saveLastPage(widget.filePath, details.newPageNumber);
    });
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

          // ✅ Set initial page ONLY ONCE
          if (!_initialized && state.filePath == widget.filePath) {
            _initialPage = state.lastPage;
            _initialized = true;

            // jump once after build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controller.jumpToPage(_initialPage);
            });
          }

          return RepaintBoundary(
            child: PdfViewerWidget(
              filePath: widget.filePath,
              controller: _controller,
              initialPageNumber: _initialPage,
              onPageChanged: _onPageChanged,
            ),
          );
        },
      ),
    );
  }
}
