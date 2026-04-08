class PdfEntity {
  final int? id;
  final String name;
  final String path;
  final DateTime? lastOpened;
  final int lastPage;

  PdfEntity({
    required this.id,
    required this.name,
    required this.path,
    required this.lastOpened,
    required this.lastPage,
  });
}
