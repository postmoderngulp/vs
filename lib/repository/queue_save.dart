import 'package:shared_preferences/shared_preferences.dart';

class QueueSave {
  Future<void> load(List<String> queue, String key) async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.setStringList(key, queue);
  }

  Future<List<String>?> unLoad(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    final item = _preferences.getStringList(key);
    return item;
  }
}
