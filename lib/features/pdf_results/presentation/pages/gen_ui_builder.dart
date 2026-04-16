import 'package:flutter/material.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/design_tokens.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/premium_card.dart';

class GenUiRenderer {
  static Widget build(Map<String, dynamic> node, {int depth = 0}) {
    if (node.isEmpty || depth > 25) return const SizedBox();

    final layout = node['layout'];

    switch (layout) {
      case 'column':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _children(node, depth),
        );

      case 'row':
        final children = _children(node, depth);

        final forceWrap = node['wrap'] == true;
        final smartWrap = children.length > 3;

        if (forceWrap || smartWrap) {
          return Wrap(spacing: DS.sm, runSpacing: DS.sm, children: children);
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: children),
        );

      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: DS.xs),
          child: Text(
            node['value'] ?? '',
            style: TextStyle(
              fontSize: (node['size'] ?? 14).toDouble(),
              fontWeight: node['bold'] == true
                  ? FontWeight.w600
                  : FontWeight.normal,
              color: node['color'] == 'muted' ? Colors.grey : Colors.black87,
            ),
          ),
        );

      case 'card':
        return DSCard(
          child: GenUiRenderer.build({
            "layout": "column",
            "children": node['children'] ?? [],
          }, depth: depth + 1),
        );

      case 'badge':
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: DS.sm,
            vertical: DS.xs,
          ),
          decoration: BoxDecoration(
            color: DS.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: DS.primary.withOpacity(0.2)),
          ),
          child: Text(
            node['value'] ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: DS.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

      /// ---------------- SPACER ----------------
      case 'spacer':
        return const SizedBox(height: DS.md);

      default:
        return const SizedBox();
    }
  }

  static List<Widget> _children(Map<String, dynamic> node, int depth) {
    return (node['children'] as List? ?? [])
        .map((e) => build(e, depth: depth + 1))
        .toList();
  }
}
