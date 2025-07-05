import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_error_model.dart';

import '../../../../core/db/cash_helper.dart';
import '../model/reset_password_model.dart';

class SettingRepo {
  SettingRepo({required this.dio});
  Dio dio;
  Future<Either<ApiErrorModel,String>> changeMyPassword(ResetPasswordModel data) async {
    try {
      // log('data: ${data.toMap()}');
      // log('token: $token');
      final response = await dio.post('custom-api/v1/change-password',
        data: data.toMap(),);
      // log('response: $response');
      if(response.data["success"] == true){
        return right(response.data['data']["message"]);
      }
      else{
        return right(
            response.data['data']["message"]);
      }
      // String message = response.data['data']["message"];
      // return message;
    }  catch (e) {
      // log('Error fetching userr: $e');
      return left(ApiErrorModel.fromJson('Error changing password: $e'));
    }
  }
}