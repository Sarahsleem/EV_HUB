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
      if (response.data is List) {
        return right( (response.data as List).map((car) => Car.fromMap(car)).toList());
      } else {
        throw Exception('Unexpected data format: Expected List but got ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
      print(e.response!.data);
      return left(ApiErrorHandler.handle(e.response!.data));
      // log('DioException during search: ${e.message}');
      throw Exception('Search failed: ${e.message}');
    } catch (e) {
      print(e);
      return left(ApiErrorHandler.handle(e));

    }
  }





  Future<void> removeFromFavorites(int carId) async {
    await dio.post('custom/v1/favorite/remove/', data: {'car_id': carId});
  }
}