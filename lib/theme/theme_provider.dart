import 'package:fireball/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Biến lưu trạng thái của chế độ
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Hàm chuyển đổi giữa chế độ sáng và tối
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Thông báo cho các widget nghe sự thay đổi
  }
}