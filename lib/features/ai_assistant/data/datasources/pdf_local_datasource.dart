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

  Future<int> updatePdf(PdfModel pdf) {
    if (pdf.id == null) {
      throw Exception("PDF id cannot be null for update");
    }

    return (db.update(
      db.pdfFiles,
    )..where((tbl) => tbl.id.equals(pdf.id!))).write(
      PdfFilesCompanion(
        name: Value(pdf.name),
        path: Value(pdf.path),
        lastOpened: Value(pdf.lastOpened),
        lastPage: Value(pdf.lastPage),
      ),
    );
  }

  Future<void> deletePdf(int id) {
    return (db.delete(db.pdfFiles)..where((tbl) => tbl.id.equals(id))).go();
  }
}
