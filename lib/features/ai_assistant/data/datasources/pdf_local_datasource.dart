import 'package:drift/drift.dart';
import 'package:nebula/features/ai_assistant/data/db/app_database.dart';
import 'package:nebula/features/ai_assistant/data/models/pdf_model.dart';

class PdfLocalDatasource {
  final AppDatabase db;

  PdfLocalDatasource(this.db);

  Future<int> insertPdf(PdfModel pdf) {
    return db
        .into(db.pdfFiles)
        .insert(
          PdfFilesCompanion.insert(
            name: pdf.name,
            path: pdf.path,
            lastOpened: Value(pdf.lastOpened),
            lastPage: Value(pdf.lastPage),
          ),
        );
  }

  Future<List<PdfModel>> getAllPdfs() async {
    final result = await db.select(db.pdfFiles).get();
    return result
        .map(
          (pdf) => PdfModel(
            id: pdf.id,
            name: pdf.name,
            path: pdf.path,
            lastOpened: pdf.lastOpened,
            lastPage: pdf.lastPage,
          ),
        )
        .toList();
  }

  Future updateLastPage(int id, int page) {
    return (db.update(db.pdfFiles)..where((tbl) => tbl.id.equals(id))).write(
      PdfFilesCompanion(lastPage: Value(page)),
    );
  }

  Future deletePdf(int id) {
    return (db.delete(db.pdfFiles)..where((tbl) => tbl.id.equals(id))).go();
  }
}
