part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}
class ChangePasswordLoadingState extends SettingState {}
class ChangePasswordSuccessState extends SettingState {}
class ChangePasswordErrorState extends SettingState {}