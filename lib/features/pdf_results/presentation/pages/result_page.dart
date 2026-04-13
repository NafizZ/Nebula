import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_cubit.dart';
import 'package:nebula/features/pdf_results/presentation/cubit/pdf_result_state.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/action_list.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/date_list.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/summary_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis Result')),
      body: BlocBuilder<PdfResultCubit, PdfResultState>(
        builder: (context, state) {
          final result = state.result;

          if (result == null) {
            return const Center(child: Text('No analysis result available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryCard(summary: result.summary),
                const SizedBox(height: 16),
                DateList(dates: result.dates),
                const SizedBox(height: 16),
                ActionList(actions: result.actions),
              ],
            ),
          );
        },
      ),
    );
  }
}
