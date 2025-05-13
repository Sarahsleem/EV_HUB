
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_model.dart';
import '../../../../../core/networking/error_handler.dart';
import '../../../signup/data/models/sign_up_response.dart';
import '../models/sign_in_model.dart';




class SignInRepo {
  final Dio _dio;

  SignInRepo(this._dio);

  // Registration API Call
  Future<Either<ApiErrorModel, SignInResponse>> login(SignIn registerModel) async {
    try {
      final response = await _dio.post(ApiConstants.login, data: registerModel.toMap());


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