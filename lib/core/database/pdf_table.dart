import 'package:drift/drift.dart';

class PdfFiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  DateTimeColumn get lastOpened => dateTime().nullable()();
  IntColumn get lastPage => integer().withDefault(const Constant(0))();
}
