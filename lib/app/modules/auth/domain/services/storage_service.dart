abstract class StorageService {
  Future<void> saveData(String key, dynamic data);
  Future<dynamic> getData(String key);
}
