import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class ThemeProvider extends ChangeNotifier{
 ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class MyThemes{
  static final darkTheme= ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.black,

  );

static final lightTheme= ThemeData(
scaffoldBackgroundColor: Colors.white,
colorScheme: ColorScheme.light(),
   primaryColor: Colors.white,
);

}
