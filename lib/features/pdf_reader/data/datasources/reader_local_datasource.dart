import 'package:drift/drift.dart';
import 'package:nebula/core/database/app_database.dart';

class ReaderLocalDatasource {
  final AppDatabase db;

  ReaderLocalDatasource(this.db);

  Future<int> getLastPage(String filePath) async {
    final query = db.select(db.pdfFiles)..where((tbl) => tbl.path.equals(filePath));
    final pdf = await query.getSingleOrNull();

    return pdf?.lastPage ?? 1;
  }

  Future<void> saveLastPage(String filePath, int page) async {
    await (db.update(
      db.pdfFiles,
    )..where((tbl) => tbl.path.equals(filePath))).write(
      PdfFilesCompanion(lastPage: Value(page)),
    );
  }
}
