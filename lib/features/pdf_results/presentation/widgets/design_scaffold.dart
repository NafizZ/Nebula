import 'package:flutter/material.dart';

class DSScaffold extends StatelessWidget {
  final Widget child;

  const DSScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF6F7FB), Colors.white],
        ),
      ),
      child: child,
    );
  }
}
