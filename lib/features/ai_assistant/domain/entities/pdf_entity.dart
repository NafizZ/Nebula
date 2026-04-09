class PdfEntity {
  final int? id;
  final String name;
  final String path;
  final DateTime? lastOpened;
  final int lastPage;

  PdfEntity({
    this.id,
    required this.name,
    required this.path,
    this.lastOpened,
    required this.lastPage,
  });

  PdfEntity copyWith({
    int? id,
    String? name,
    String? path,
    DateTime? lastOpened,
    int? lastPage,
  }) {
    return PdfEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      lastOpened: lastOpened ?? this.lastOpened,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
