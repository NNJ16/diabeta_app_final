import 'dart:convert';
import 'package:diabeta_app/model/ReceivedNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  DataStore._privateConstructor();

  static final DataStore _instance = DataStore._privateConstructor();

  static DataStore get shared => _instance;

  static final Future<SharedPreferences> _store = SharedPreferences.getInstance();

  List<dynamic> _reminders = [];

  
  Future clearAll() async {
    final SharedPreferences store = await _store;
    _reminders = [];
    await store.clear();
  }

  Future<List<dynamic>> getReminderList() async {
    final SharedPreferences store = await _store;
    List<dynamic> _reminders = jsonDecode(store.getString("reminders") ?? '[]');
    print("_reminders");
    print(_reminders);
    return _reminders;
  }

  setReminderList(ReceivedNotification value) {
    _store.then((store) {
      _reminders = jsonDecode(store.getString("reminders") ?? '[]');
      _reminders.insert(0, {
        "id": value.id,
        "body": value.body,
        "payload": value.payload,
        "title": value.title,
      });
      String newReminders = jsonEncode(_reminders);
      print("newReminders");
      print(newReminders);
      store.setString("reminders", newReminders);
    });
  }

  setReminderFullList(List<dynamic> value) {
    _store.then((store) {
      String newReminders = jsonEncode(value);
      print("newReminders");
      print(newReminders);
      store.setString("reminders", newReminders);
    });
  }
}
