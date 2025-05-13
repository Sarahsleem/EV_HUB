import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evhub/core/networking/dio_factory.dart';
import 'package:evhub/features/login/data/models/sign_in_reponse.dart';
import 'package:evhub/features/signup/data/models/sign_up_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/db/cash_helper.dart';

import '../data/repo/sign_up_repo.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authService) : super(SignUpInitial());
  final SignUpRepo authService;
  String logInPhone="" ;
  String signUpPhone="" ;
  static SignUpCubit get(context) => BlocProvider.of(context);

  void changeSignUpPhone(String newPhone) {
    signUpPhone = newPhone;
    // emit(ChangePhone());
  }
  bool? isChecked = false;
//   String signUpPhone="" ;
int index = 0;
//
  bool isObscureText1 = true;
  bool isObscureText2 = true;

//
  void obscureText1() {
    isObscureText1 = !isObscureText1;
    emit(ObscureText1());
  }
//
  void obscureText2() {
    isObscureText2 = !isObscureText2;
    emit(ObscureText2());
  }
  // void changeSignUpPhone(String newPhone) {
  //   signUpPhone = newPhone;
  //   // emit(ChangePhone());
  // }
//   void changeCheckboxValue(bool newIsChecked) {
//     isChecked = newIsChecked;
//     emit(ChangeCheckboxValue());
//   }
//
//
//
  Future<void> signUp( SignUp signUpModel) async {
  emit(SignUpLoading());
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if (!connectivityResult.contains(ConnectivityResult.none)) {
    final response = await authService.register(signUpModel);
    response.fold(
            (l) => emit(SignUpFailed(message: l.message!)),
            (r)  async {

              DioFactory.setTokenIntoHeaderAfterLogin(r.data!.authToken!);
          CashHelper.setStringSecured(
            key: Keys.signUpResponse,
            value: r.toString(),
          );
          CashHelper.setStringSecured(
            key: Keys.token,
            value: r.data!.authToken!,
          );

          emit(SignUpSuccess());
          print('saved ${r.toString()}');
        }
    );
  } else {
    emit(SignUpFailed(message: 'No internet connection.'));
  }
}
  void focusNextField(BuildContext context) {
    if (index < 4) {
      FocusScope.of(context).nextFocus();
    }
  }

  void focusPreviousField(BuildContext context) {
    if (index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }
}