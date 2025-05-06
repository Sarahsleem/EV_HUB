part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial(ThemeMode themeMode) : super(themeMode);
}

final class ThemeChanged extends ThemeState {
  const ThemeChanged(ThemeMode themeMode) : super(themeMode);
}
