part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {

}
final class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure( this.message);
}final class UpdateProfileLoading extends ProfileState {}
final class UpdateProfileSuccess extends ProfileState {

}
final class UpdateProfileError extends ProfileState {

}