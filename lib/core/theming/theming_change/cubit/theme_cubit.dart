import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../db/cash_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(_loadThemeMode())); // Load theme from storage

  // Singleton accessor
  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  // Load theme mode from shared preferences
  static ThemeMode _loadThemeMode() {
    final theme = CashHelper.getString(key: Keys.theme);
    if (theme == 'dark') {
      return ThemeMode.dark;
    } else if (theme == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.system; // Default to system if no value is stored
  }

  ThemeMode get themeMode => state.themeMode;

  // Return the correct theme
  ThemeData getTheme() {
    return themeMode == ThemeMode.light
        ? ThemeData.light(useMaterial3: false)
        : ThemeData.dark();
  }

  // Toggle between light and dark themes
  Future<void> toggleTheme() async {
    final newTheme = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await CashHelper.putString(key: Keys.theme, value: newTheme == ThemeMode.dark ? 'dark' : 'light');

    emit(ThemeChanged(newTheme));
  }

  // Set system theme
  void setSystemTheme() {
    CashHelper.putString(key: Keys.theme, value: 'system');
    emit(ThemeChanged(ThemeMode.system));
  }
}
