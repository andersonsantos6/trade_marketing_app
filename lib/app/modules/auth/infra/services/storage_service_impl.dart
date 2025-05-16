import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/services/storage_service.dart';

class StorageServiceImpl implements StorageService {
  final Box _box;

  StorageServiceImpl(this._box);

  @override
  Future<dynamic> getData(String key) async {
    return _box.get(key);
  }

  @override
  Future<void> saveData(String key, dynamic data) async {
    await _box.put(key, data);
  }

  Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
