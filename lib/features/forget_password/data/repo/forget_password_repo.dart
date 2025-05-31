import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/core/networking/error_handler.dart';

class ForgetPasswordRepo {
  ForgetPasswordRepo(this.dio);

  Dio dio;

  Future<Either<ApiErrorModel, String>> sendEmail(String email) async {
    try {
      await dio.post(ApiConstants.forgetPassword, data: {"email": email});
      return right('OTP send to your email');
    } on DioException catch (e) {
      // log('DioException: ${e.message}');
      // throw Exception('Failed to load brands: ${e.message}');
      return left(ApiErrorHandler.handle(e.message!));
    } catch (e) {
      print(e.toString());
      return left(ApiErrorHandler.handle(e.toString()));
    }
  }

  Future<Either<ApiErrorModel, String>> verifyOtp(String email,
      String otp) async {
    try {
      final response = await dio.post(
        ApiConstants.verifyOtp,

        data: {"email": email, "code": otp},
      );

      return right('OTP verified');
    } catch (e) {
      return left(ApiErrorHandler.handle(e.toString()));
    }
  }

  Future<Either<ApiErrorModel, String>> changepassword(String email, String password) async {


    try {
      final response = await dio.post(
        ApiConstants.resetPassword,

        data: {"email": email, "new_password": password},
      );

      return right('Password changed');
    } catch (e) {
return left(ApiErrorHandler.handle(e.toString()));
    }
  }



}