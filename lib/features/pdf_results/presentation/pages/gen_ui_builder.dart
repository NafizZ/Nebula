import 'package:flutter/material.dart';

class GenUiRenderer {
  static Widget build(Map<String, dynamic> node, {int depth = 0}) {
    if (node.isEmpty) return const SizedBox();
    if (depth > 20) return const SizedBox();

    final layout = node['layout'];

    switch (layout) {
      case 'column':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (node['children'] as List? ?? [])
              .map((e) => build(e, depth: depth + 1))
              .toList(),
        );

      case 'row':
        final childrenWidgets = (node['children'] as List? ?? [])
            .map((e) => build(e, depth: depth + 1))
            .toList();

        final wrap = node['wrap'] == true;

        return wrap
            ? Wrap(spacing: 8, runSpacing: 8, children: childrenWidgets)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: childrenWidgets
                      .map(
                        (w) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: w,
                        ),
                      )
                      .toList(),
                ),
              );
      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            node['value'] ?? '',
            style: TextStyle(
              fontSize: (node['size'] ?? 14).toDouble(),
              fontWeight: node['bold'] == true
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: node['color'] == 'muted' ? Colors.grey : Colors.black,
            ),
          ),
        );
      case 'card':
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: build({
              "layout": "column",
              "children": node['children'] ?? [],
            }, depth: depth + 1),
          ),
        );
      case 'badge':
        return Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            node['value'] ?? '',
            style: const TextStyle(fontSize: 12),
          ),
        );
      case 'spacer':
        return const SizedBox(height: 12);
      default:
        return const SizedBox();
    }
  }
}
