part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {

}
final class ObscureText1 extends SignUpState {}

final class ObscureText2 extends SignUpState {}
final class ChangeCheckboxValue extends SignUpState {}
final class SignUpSuccess extends SignUpState {
  // final SignInResponse signUpResponse;
  // SignUpSuccess({required this.signUpResponse});

}
final class SignUpFailed extends SignUpState {
  final String message;
  SignUpFailed({required this.message});
}
