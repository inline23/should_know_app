import 'package:flutter/material.dart';
import 'package:should_know_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  String lang = 'ar';

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  void changeLang(String language) {
    lang = language;
    notifyListeners();
  }

  String _selectedLanguage = 'ar';

  String get selectedLanguage => _selectedLanguage;


  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
