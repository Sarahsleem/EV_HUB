part of 'forget_password_cubit.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}
class LoadingSendEmail extends ForgetPasswordState{}
class ErrorSendEmail extends ForgetPasswordState{
  final ApiErrorModel error;
  ErrorSendEmail(this.error);
}
class SuccesSendEmail extends ForgetPasswordState{
  final String msg;
  final String email;
  SuccesSendEmail(this.msg,this.email);
}
class LoadingVerifyCode extends ForgetPasswordState{}
class ErrorVerifyCode extends ForgetPasswordState{
  final ApiErrorModel error;
  ErrorVerifyCode(this.error);
}
class SuccesVerifyCode extends ForgetPasswordState{
  final String msg;
  final String email;
  SuccesVerifyCode(this.msg,this.email);
}

class LoadingChangePassword extends ForgetPasswordState{}
class ErrorChangePassword extends ForgetPasswordState{
  final ApiErrorModel error;
  ErrorChangePassword(this.error);
}
class SuccesChangePassword extends ForgetPasswordState{
  final String msg;
  final String email;
  SuccesChangePassword(this.msg,this.email);
}