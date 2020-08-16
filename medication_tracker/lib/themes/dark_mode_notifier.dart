import 'package:flutter/material.dart';

/// Checks if dark mode is currently active.
class DarkModeNotifier extends ChangeNotifier {
  bool isDarkModeOn = false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
  }
}