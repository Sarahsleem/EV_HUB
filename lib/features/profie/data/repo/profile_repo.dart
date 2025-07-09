
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/core/networking/api_error_model.dart';

import '../../../../core/db/cash_helper.dart';

import '../../../../core/networking/error_handler.dart';
import '../models/profile_model.dart';
import '../models/updated_profle_model.dart';

class ProfileRepo {
  final Dio dio;

  ProfileRepo(this.dio);
  Future<Either<ApiErrorModel,UpdatedProfileModel>> updataProfile(UpdatedProfileModel data) async {

    try {

      final response = await dio.put('custom-api/v1/profile/update',
        data: data.toMap(),);

      UpdatedProfileModel profilUpdated = UpdatedProfileModel.fromMap(response.data['data']);
      return right(profilUpdated);
    }  catch (e) {
      return left(ApiErrorHandler.handle(e));
      // log('Error fetching userr: $e');
      // throw Exception('Failed to load userr');
    }
  }
  Future<Either<ApiErrorModel, ProfileModel>> fetchProfile() async {
    String token = await CashHelper.getStringSecured(key: Keys.token);

    try {
      var response = await dio.get(
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

      return right(ProfileModel.fromMap(response.data['data']));
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
