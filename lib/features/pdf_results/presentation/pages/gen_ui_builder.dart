import 'package:flutter/material.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/design_tokens.dart';
import 'package:nebula/features/pdf_results/presentation/widgets/premium_card.dart';

class GenUiRenderer {
  static Widget build(Map<String, dynamic> node, {int depth = 0}) {
    if (node.isEmpty || depth > 25) return const SizedBox();

    final layout = node['layout'] ?? node['type'] ?? '';

    switch (layout) {
      case 'column':
        final children = _children(node, depth);

        if (children.isEmpty) {
          final value = _value(node);
          return value.isEmpty
              ? const SizedBox()
              : Text(value, style: const TextStyle(fontSize: 14));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );

      case 'row':
        final children = _children(node, depth);

        if (children.isEmpty) return const SizedBox();

        return Wrap(spacing: DS.sm, runSpacing: DS.sm, children: children);

      case 'text':
        final value = _value(node);

        if (value.trim().isEmpty) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: DS.xs),
          child: Text(
            value,
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
        final children = _children(node, depth);
        final value = _value(node);

        return DSCard(
          child: children.isEmpty
              ? Text(
                  value.isEmpty ? "No data" : value,
                  style: const TextStyle(fontSize: 14),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
        );

      case 'badge':
        final value = _value(node);

        if (value.isEmpty) return const SizedBox();

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
            value,
            style: const TextStyle(
              fontSize: 12,
              color: DS.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );

      case 'spacer':
        final isHorizontal = node['horizontal'] == true;

        return isHorizontal
            ? const SizedBox(width: DS.md)
            : const SizedBox(height: DS.md);

      default:
        final value = _value(node);
        return value.isNotEmpty
            ? Text(value, style: const TextStyle(fontSize: 14))
            : const SizedBox();
    }
  }

  static List<Widget> _children(Map<String, dynamic> node, int depth) {
    final raw = node['children'];

    if (raw == null || raw is! List || raw.isEmpty) return [];

    return raw.map((e) {
      if (e is Map<String, dynamic>) {
        if ((node['layout'] == 'row' || node['type'] == 'row') &&
            e['layout'] == 'spacer') {
          e['horizontal'] = true;
        }

        return build(e, depth: depth + 1);
      }
      return const SizedBox();
    }).toList();
  }

  static String _value(Map<String, dynamic> node) {
    return (node['value'] ?? node['text'] ?? node['content'] ?? '').toString();
  }
}
