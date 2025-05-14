import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  bool _colorBlindMode = false;
  bool _highContrast = false;
  String _locale = 'en';

  bool get darkMode => _darkMode;
  bool get colorBlindMode => _colorBlindMode;
  bool get highContrast => _highContrast;
  String get locale => _locale;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void toggleColorBlindMode(bool value) {
    _colorBlindMode = value;
    notifyListeners();
  }

  void toggleHighContrast(bool value) {
    _highContrast = value;
    notifyListeners();
  }

  void setLocale(String value) {
    _locale = value;
    notifyListeners();
  }
}