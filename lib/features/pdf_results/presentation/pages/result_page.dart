import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_cubit.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_state.dart';
import 'package:nebula/features/pdf_results/presentation/pages/gen_ui_builder.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Overview'), centerTitle: true),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF6F7FB), Colors.white],
          ),
        ),

        child: BlocBuilder<PdfResultCubit, PdfResultState>(
          builder: (context, state) {
            final result = state.result;

            if (state.status == PdfResultStatus.idle) {
              return const Center(child: Text("No analysis yet"));
            }

            if (state.status == PdfResultStatus.loading || result == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final uiTree = result.uiTree;
            if (uiTree == null) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  result.summary.isEmpty
                      ? "No content available"
                      : result.summary,
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: RepaintBoundary(child: GenUiRenderer.build(uiTree)),
            );
          },
        ),
      ),
    );
  }
}
