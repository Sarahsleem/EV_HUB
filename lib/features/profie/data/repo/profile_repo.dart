
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/core/networking/api_error_model.dart';

import '../../../../core/db/cash_helper.dart';

import '../../../../core/networking/error_handler.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  final Dio _dio;

  ProfileRepo(this._dio);

  Future<Either<ApiErrorModel, ProfileModel>> fetchProfile() async {
    String token = await CashHelper.getStringSecured(key: Keys.token);

    try {
      var response = await _dio.get(
        ApiConstants.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      return right(ProfileModel.fromMap(response.data));
    } catch (e) {
      print(e);
      return left(ApiErrorHandler.handle(e));
    }
  }

  //   Future<Either<ApiErrorModel,String>> deletAccount() async {
  //     try {
  //       Response response = await _dio.delete(

  //         NetworkConstant.deleteAccount,
  //       );
  //       return Right(response
  //           .data["message"]); // Assuming the response has the profile dat
  //     } catch (e) {
  //      // log(e.toString());
  //       return Left(ApiErrorHandler.handle(e));
  //     }
  //   }
  // }
}
