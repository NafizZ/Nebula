class GenUiValidator {
  static const allowed = {'column', 'row', 'text', 'card', 'badge', 'spacer'};

  static Map<String, dynamic>? validate(Map<String, dynamic> node) {
    if (node['layout'] == null) return null;
    if (!allowed.contains(node['layout'])) return null;
    return node;
  }
}
