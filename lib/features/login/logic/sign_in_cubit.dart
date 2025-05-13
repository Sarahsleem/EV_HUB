import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/db/cash_helper.dart';

import '../../../core/networking/api_error_model.dart';
import '../../../core/networking/dio_factory.dart';
import '../../signup/data/models/sign_up_response.dart';
import '../data/models/sign_in_model.dart';
import '../data/repo/sign_in_repo.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authService) : super(SignInInitial());
 final SignInRepo authService;

  static SignInCubit get(context) => BlocProvider.of(context);
  bool isObscureText1 = true;
  bool isObscureText2 = true;
  bool? isChecked = false;
  String logInPhone=" ";
  int index = 0;
  String email = '';
  void getEmail(String value) => email = value;
  void changeLogInPhone(String newPhone) {
    logInPhone = newPhone;
    // emit(ChangePhone());
  }


/*************  ✨ Windsurf Command ⭐  *************/
/// Toggles the visibility of the text for the first input field by
/// inverting the `isObscureText1` boolean and emits an `ObscureText1` state.

/*******  bcfa653e-82de-430f-ab5c-ceedf12831df  *******/
  void obscureText1() {
    isObscureText1 = !isObscureText1;
    emit(ObscureText1());
  }

  void changeSignInPhone(String newPhone) {
    logInPhone = newPhone;
    // emit(ChangePhone());
  }
  void obscureText2() {
    isObscureText2 = !isObscureText2;
    emit(ObscureText2());
  }

  void changeCheckboxValue(bool newIsChecked) {
    isChecked = newIsChecked;
    emit(ChangeCheckboxValue());
  }
  Future<void> login( SignIn loginModel) async {
    emit(SignInLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authService.login(loginModel);
      response.fold(
            (r) => emit(SignInFailed(message: r.message!)),
            (r) {
          // Save sign-in response securely
          CashHelper.setStringSecured(
            key: Keys.signInResponse,
            value: r.toString(),
          );
          CashHelper.setStringSecured(
            key: Keys.token,
            value: r.data!.authToken!,
          );
          DioFactory.setTokenIntoHeaderAfterLogin(r.data!.authToken!);
          emit(SignInSuccess(signInResponse: r));
          print('saved ${r.toString()}');
        },
      );
    } else {
      emit(SignInFailed(message: 'No internet connection.'));
    }
  }
  // Future<void> forgetPaswword(String email) async {
  //   emit(ForgetPasswordLoading());
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  //   if (!connectivityResult.contains(ConnectivityResult.none)) {
  //     final response = await authService.forgetpassword(email: email);
  //     response.fold(
  //
  //             (l) =>
  //                 emit(ForgetPasswordFailure( l )),
  //             (r)  {
  //               log('yarab nekhlas');
  //           emit(ForgetPasswordSuccess());
  //         }
  //     );
  //   } else {
  //     emit(ForgetPasswordFailure(ApiErrorModel(message: 'No internet connection')));
  //   }
  // }

  // Future<void> resendCode(String email) async {
  //   emit(ResendCodeLoading());
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  //   if (!connectivityResult.contains(ConnectivityResult.none)) {
  //     final response = await authService.resendCode(email: email);
  //     response.fold(
  //             (l) => emit(ResendCodeFailure( l )),
  //             (r)  {
  //           emit(ResendCodeSuccess());
  //         }
  //     );
  //   } else {
  //     emit(ResendCodeFailure(ApiErrorModel(message: 'No internet connection')));
  //   }
  // }
  //
  // Future<void> otp(OtpModel otpModel) async {
  //   emit(OtpLoading());
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  //   if (!connectivityResult.contains(ConnectivityResult.none)) {
  //     final response = await authService.otp(otpModel: otpModel);
  //     response.fold(
  //             (l) => emit(OtpFailure( l )),
  //             (r)  {
  //           CashHelper.setStringSecured(
  //             key: Keys.secretKey,
  //             value: r.secretKey!,
  //           );
  //           emit(OtpSuccess());
  //         }
  //     );
  //   } else {
  //     emit(OtpFailure(ApiErrorModel(message: 'No internet connection')));
  //   }
  // }

  // Future<void> resetPassword(ResetPasswordModel resetPasswordModel) async {
  //   emit(ResetPasswordLoading());
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  //   if (!connectivityResult.contains(ConnectivityResult.none)) {
  //     final response = await authService.resetPssword(resetPasswordModel: resetPasswordModel);
  //     response.fold(
  //             (l) => emit(ResetPasswordFailure( l )),
  //             (r)  {
  //           emit(ResetPasswordSuccess());
  //         }
  //     );
  //   } else {
  //     emit(ResetPasswordFailure(ApiErrorModel(message: 'No internet connection')));
  //   }
  // }

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

  void clearOtpFields(List<TextEditingController> otpControllers) {
    for (var controller in otpControllers) {
      controller.clear(); // Clear the text field
    }
    index = 0; // Reset index to the first field
  }





}
