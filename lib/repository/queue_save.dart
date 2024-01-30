import 'package:shared_preferences/shared_preferences.dart';

class QueueSave {
  void load(List<String> queue) async {
    final _preferences = await SharedPreferences.getInstance();
    await _preferences.setStringList('queue', queue);
  }

  Future<List<String>?> unLoad() async {
    final _preferences = await SharedPreferences.getInstance();
    final item = _preferences.getStringList('queue');
    return item;
  }
}
