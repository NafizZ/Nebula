import 'package:nebula/features/pdf_reader/domain/repositories/reader_repository.dart';

class GetLastPage {
  final ReaderRepository repository;

  GetLastPage(this.repository);

  Future<int> call(String filePath) {
    return repository.getLastPage(filePath);
  }
}
