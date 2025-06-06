import 'package:bloc/bloc.dart';
import 'package:evhub/features/otp/data/repo/otp_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/otp_model.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.otpRepo) : super(OtpInitial());
  static OtpCubit get(context) => BlocProvider.of(context);
  OTPRepo otpRepo;
  int index = 0;
  void focusNextField(BuildContext context) {
    if (index < 3) { // Update to 3 since the last index is 3 for 4 fields
      index++;
      FocusScope.of(context).nextFocus();
    }
  }

  void focusPreviousField(BuildContext context) {
    if (index > 0) {
      index--;
      FocusScope.of(context).previousFocus();
    }
  }
  Future<void> sendOTP(OTPModel otpmodel) async {
    emit(OtpLoadingState());
    final otp = await otpRepo.sendOTP(otpmodel: otpmodel);
    emit(OtpSuccessState());
  }
}
