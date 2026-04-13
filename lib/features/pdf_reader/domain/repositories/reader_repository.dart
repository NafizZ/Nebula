abstract class ReaderRepository {
  Future<int> getLastPage(String filePath);
  Future<void> saveLastPage(String filePath, int page);
}
