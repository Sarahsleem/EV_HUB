
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/dio_factory.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_model.dart';
import '../../../../core/networking/error_handler.dart';
import '../models/sign_up_model.dart';
import '../models/sign_up_response.dart';



class SignUpRepo {
  final Dio _dio;

  SignUpRepo(this._dio);

  // Registration API Call
  Future<Either<ApiErrorModel, SignInResponse>> register(SignUp registerModel) async {
    try {
      DioFactory.removeTokenIntoHeaderAfterLogout();
      final response = await _dio.post(ApiConstants.registeration, data: registerModel.toMap());


        return Right(SignInResponse.fromMap(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));

    }
  }



  // Logout API Call
  // Future<Either<ApiErrorModel, void>> logout(String token) async {
  //   try {
  //     final response = await _dio.post(
  //       NetworkConstant.logout,
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $token'},
  //       ),
  //     );
  //
  //     return const Right(null);
  //   } catch (e) {
  //     return left(ApiErrorHandler.handle(e));
  //
  //   }
  //
  //   }

}