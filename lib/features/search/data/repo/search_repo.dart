import 'package:dio/dio.dart';

import '../../../home/data/model/car_model.dart';

class SearchRepo{
  SearchRepo({required this.dio});
  Dio dio;
  Future<List<Car>> searchCars({
    String? brandName,
    String? modelName,
    String? conditionName,
    String? colorName,
    String? usedSinceName,
    String? bodyStyleName,
    String? className,
    String? carClassName,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        if (brandName != null) 'car-brand': brandName,
        if (modelName != null) 'model': modelName,
        if (conditionName != null) 'condition': conditionName,
        if (colorName != null) 'color': colorName,
        if (usedSinceName != null) 'used-since': usedSinceName,
        if (bodyStyleName != null) 'body-style': bodyStyleName,
        if (className != null) 'class': className,
        if (carClassName != null) 'car_class': carClassName,
        if (priceMin != null) 'price_min': priceMin.toString(),
        if (priceMax != null) 'price_max': priceMax.toString(),
      };

      final response = await dio.get(
        'https://evhubtl.com/wp-json/custom-api/v1/search-cars',
        queryParameters: queryParams,
      );

      if (response.data is List) {
        return (response.data as List).map((car) => Car.fromMap(car)).toList();
      } else {
        throw Exception('Unexpected data format: Expected List but got ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
     // log('DioException during search: ${e.message}');
      throw Exception('Search failed: ${e.message}');
    } catch (e) {
     // log('General error during search: $e');
      throw Exception('Search failed');
    }
  }
}