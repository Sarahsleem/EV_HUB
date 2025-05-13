part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {

}

final class SignInInitial extends SignInState {}
final class SignInSuccess extends SignInState {
  final SignInResponse signInResponse;
  SignInSuccess({required this.signInResponse});
}
final class SignInLoading extends SignInState {
}

final class ObscureText1 extends SignInState {}

final class ObscureText2 extends SignInState {}

final class ChangeCheckboxValue extends SignInState {}



final class SignInFailed extends SignInState {
  final String message;
  SignInFailed({required this.message});
}
final class ForgetPasswordLoading extends SignInState {}

final class ForgetPasswordSuccess extends SignInState {}

final class ForgetPasswordFailure extends SignInState {
  final ApiErrorModel error;

  ForgetPasswordFailure( this.error);
}

final class ResendCodeLoading extends SignInState {}

final class ResendCodeSuccess extends SignInState {}

final class ResendCodeFailure extends SignInState {
  final ApiErrorModel error;

  ResendCodeFailure( this.error);
}

final class OtpLoading extends SignInState {}

final class OtpSuccess extends  SignInState {}

final class OtpFailure extends SignInState {
  final ApiErrorModel error;

  OtpFailure( this.error);
}

final class ResetPasswordLoading extends SignInState {}

final class  ResetPasswordSuccess extends SignInState {}

final class  ResetPasswordFailure extends SignInState {
  final ApiErrorModel error;

  ResetPasswordFailure( this.error);
}