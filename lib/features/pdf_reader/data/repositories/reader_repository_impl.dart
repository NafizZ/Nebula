import 'package:nebula/features/pdf_reader/data/datasources/reader_local_datasource.dart';
import 'package:nebula/features/pdf_reader/domain/repositories/reader_repository.dart';

class ReaderRepositoryImpl implements ReaderRepository {
  final ReaderLocalDatasource localDatasource;

  ReaderRepositoryImpl(this.localDatasource);

  @override
  Future<int> getLastPage(String filePath) {
    return localDatasource.getLastPage(filePath);
  }

  @override
  Future<void> saveLastPage(String filePath, int page) {
    return localDatasource.saveLastPage(filePath, page);
  }
}
