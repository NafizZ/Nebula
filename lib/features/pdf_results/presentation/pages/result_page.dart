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
      appBar: AppBar(title: const Text('AI GenUI Result')),
      body: BlocBuilder<PdfResultCubit, PdfResultState>(
        builder: (context, state) {
          final result = state.result;

          if (result == null) {
            return const Center(child: Text('No result'));
          }

          final uiTree = result.uiTree;

          if (uiTree == null) {
            return Center(child: Text(result.summary));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: GenUiRenderer.build(uiTree),
          );
        },
      ),
    );
  }
}
