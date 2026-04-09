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
}
