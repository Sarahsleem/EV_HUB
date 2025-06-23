import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/db/cash_helper.dart';
import '../../../../core/networking/api_error_model.dart';
import '../../../../core/networking/error_handler.dart';
import '../../../add_new_car/data/model/car_request_model.dart';
import '../../../home/data/model/car_model.dart';

class EditCarRepo{
  Dio dio;
  EditCarRepo(this.dio);
  Future<Either<ApiErrorModel,Car>> editCars(int id,CarRequestModel car) async {
    try {

      final response = await dio.post('https://evhubtl.com/wp-json/wp/v2/cars/$id',
        data: car.toJson(),

      );

      print('Response Data: ${response.data}');
      return right(Car.fromMap(response.data));

    }  catch (e) {
      //   log('Error fetching cars: $e');
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<int> postCarImage(File imageFile) async {
    final String? token = await CashHelper.getStringSecured(key: Keys.token);
    print('token: $token');
    final fileName = basename(imageFile.path);

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    try {
      final response = await dio.post(
        'https://evhubtl.com/wp-json/custom/v1/upload/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('✅ Upload successful: ${response.data}');
        return response.data['id'];
      } else {
        print('❌ Failed: ${response.statusCode}');
        return -1;
      }
    } catch (e) {
      print('🚫 Error: $e');
    }

    return -1;
  }

}