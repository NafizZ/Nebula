import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_cubit.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_state.dart';
import 'package:nebula/features/pdf_results/presentation/pages/gen_ui_builder.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/design_scaffold.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text('AI Overview'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: BlocBuilder<PdfResultCubit, PdfResultState>(
          builder: (context, state) {
            final result = state.result;

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
              padding: const EdgeInsets.all(16),
              child: GenUiRenderer.build(uiTree),
            );
          },
        ),
      ),
    );
  }
}
