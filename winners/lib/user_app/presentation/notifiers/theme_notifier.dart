import 'package:winners/user_app/core/constants/persistent_keys.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  ThemeNotifier(this._themeData) {
    loadPersistedTheme();
  }

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData, bool system) async {
    _themeData = themeData;
    await persistTheme(themeData, system);
    notifyListeners();
  }

  Future<bool> loadPersistedTheme() async {
    await RxSharedPreferences.getInstance().read<String>(
      PersistentKeys.themeKey,
      (p0) {
        if (p0 == 'DARK') {
          setTheme(AppThemes().darkTheme, false);
        } else if (p0 == 'LIGHT') {
          setTheme(AppThemes().lightTheme, false);
        } else {
          if (brightness == Brightness.light) {
            setTheme(AppThemes().lightTheme, true);
          } else if (brightness == Brightness.dark) {
            setTheme(AppThemes().darkTheme, true);
          }
        }
        notifyListeners();
        return p0.toString();
      },
    );
    bool done = true;
    return done;
  }

  Future<void> persistTheme(ThemeData themeData, bool system) async {
    bool isDarkTheme = themeData == AppThemes().darkTheme;

    RxSharedPreferences.getInstance().write<String>(
      PersistentKeys.themeKey,
      system
          ? "system"
          : isDarkTheme
              ? 'DARK'
              : 'LIGHT',
      (p0) => system
          ? "system"
          : isDarkTheme
              ? 'DARK'
              : 'LIGHT',
    );
  }
}
