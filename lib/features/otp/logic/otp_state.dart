part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}
class OtpLoadingState extends OtpState{}
class OtpSuccessState extends OtpState{

}