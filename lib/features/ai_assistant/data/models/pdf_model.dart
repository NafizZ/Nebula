class PdfModel {
  final int? id;
  final String name;
  final String path;
  final DateTime? lastOpened;
  final int lastPage;

  PdfModel({
    this.id,
    required this.name,
    required this.path,
    this.lastOpened,
    this.lastPage = 0,
  });

  PdfModel copyWith({
    int? id,
    String? name,
    String? path,
    DateTime? lastOpened,
    int? lastPage,
  }) {
    return PdfModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      lastOpened: lastOpened ?? this.lastOpened,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
