import 'package:flutter/material.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/design_tokens.dart';

class DSCard extends StatelessWidget {
  final Widget child;

  const DSCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: DS.sm),
      padding: const EdgeInsets.all(DS.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.radiusLg),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}
