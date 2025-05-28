import 'package:bloc/bloc.dart';
import 'package:evhub/core/networking/dio_factory.dart';
import 'package:evhub/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/networking/api_error_model.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  ForgetPasswordRepo forgetPasswordRepo;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  int index = 0;
  void focusNextField(BuildContext context) {
    if (index < 5) { // Update to 3 since the last index is 3 for 4 fields
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
  Future<void> sentEmail(String email)async{
    DioFactory.removeTokenIntoHeaderAfterLogout();
    emit(LoadingSendEmail());
    var response= await forgetPasswordRepo.sendEmail(email);
    response.fold(
          (l) {
        print('Error: $l');
        emit(ErrorSendEmail(l));
      },
          (r) {
        print('Success: $r');
        emit(SuccesSendEmail(r,email));
      },
    );

  }
  Future<void> verifyCode(String email,String code)async {
    emit(LoadingVerifyCode());
    var response= await forgetPasswordRepo.verifyOtp(email,code);
    response.fold(
          (l) {
        print('Error: $l');
        emit(ErrorVerifyCode(l));
      },
          (r) {
        print('Success: $r');
        emit(SuccesVerifyCode(r,email));
      },
    );
  }
  Future<void> changePassword(String email,String password)async {
    emit(LoadingChangePassword());
    var response= await forgetPasswordRepo.changepassword(email,password);
    response.fold(
          (l) {
        print('Error: $l');
        emit(ErrorChangePassword(l));
      },
          (r) {
        print('Success: $r');
        emit(SuccesChangePassword(r,email));
      },
    );
  }
}
