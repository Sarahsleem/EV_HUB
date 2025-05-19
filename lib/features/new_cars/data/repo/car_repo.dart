import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';

import '../../../home/data/model/car_model.dart';

class CarsRepo{
  Dio dio;
  CarsRepo(this.dio);
  Future<Either<String,List<Car>>> fetchCarsByBrandIdFromApi(int brandId) async {
    try {
      final response = await dio.get(
        ApiConstants.cars,
        queryParameters: {
          'car-brand': brandId,  // استخدام الـ brandId بدلاً من القيمة الثابتة
          'per_page': 100,
          'condition': 13
          // تحديد العدد الأقصى للسيارات المسترجعة
        },
      );

      // Parse the response data into a List<Car>
      if (response.data is List) {
        return right((response.data as List).map((car) => Car.fromMap(car)).toList())    ;
      } else {
        throw Exception('Unexpected data format: Expected List but got ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
      return left(e.runtimeType.toString());

    } catch (e) {
      return left(e.runtimeType.toString());
    }
  }

}