import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_cubit.dart';
import 'package:nebula/features/ai_assistant/presentation/cubit/pdf_state.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PdfCubit, PdfState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🧠 SUMMARY
                const Text(
                  "🧠 Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(state.summary ?? "No summary found"),

                const SizedBox(height: 20),

                // 📅 DATES
                const Text(
                  "📅 Important Dates",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                ...state.dates.map((d) => Text("• $d")),

                const SizedBox(height: 20),

                // ⚡ ACTIONS
                const Text(
                  "⚡ Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                ...state.actions.map((a) => Text("• $a")),
              ],
            ),
          );
        },
      ),
    );
  }
}
