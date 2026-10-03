import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppState(this._preferences);

  static const _darkModeKey = 'dark_mode';
  final SharedPreferences _preferences;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void initialize() {
    _isDarkMode = _preferences.getBool(_darkModeKey) ?? false;
  }

  Future<void> setDarkMode(bool enabled) async {
    await _preferences.setBool(_darkModeKey, enabled);
    _isDarkMode = enabled;
    notifyListeners();
  }
}
