import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/features/home/data/model/car_model.dart';

import '../../../../core/networking/error_handler.dart';

class WishListRepo{
  final Dio dio;

  WishListRepo(this.dio);
  Future<String> addToFavorites(int carId) async {
   var response =await dio.post('custom/v1/favorite/', data: {'car_id': carId});
   return response.data['message'];

  }

  Future<Either<ApiErrorModel, List<Car>>> getFavorites() async {
    try {
      final response = await dio.get('custom/v1/favorites/');
      final responseData = response.data;

      // Expecting a JSON map with a "data" list
      if (responseData is Map<String, dynamic> && responseData['data'] is List) {
        final carsJson = responseData['data'] as List;
        final cars = carsJson.map((e) => Car.fromMap(e)).toList();
        return right(cars);
      } else {
        print('❌ Invalid response format: $responseData');
        return left(ApiErrorModel(message: 'Invalid data structure from API'));
      }
    } catch (e) {
      print('❌ Dio error: $e');
      return left(ApiErrorHandler.handle(e));
    }
  }





  Future<void> removeFromFavorites(int carId) async {
    await dio.post('custom/v1/favorite/remove/', data: {'car_id': carId});
  }
}