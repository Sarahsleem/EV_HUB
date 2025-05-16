
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';

import '../model/car_brand.dart';
import '../model/car_model.dart';

class HomeRepo{
  Dio dio;
  HomeRepo(this.dio);
  Future<Either<String,List<AdsModel>>> getADS2()async{
try{
  var response =await dio.get(ApiConstants.ads2);
  return right((response.data as List).map((e) => AdsModel.fromJson(e)).toList());
  }catch(e){
return left('f');
  }
}  Future<Either<String,List<AdsModel>>> getADS1()async{
try{
  var response =await dio.get(ApiConstants.ads1);
  return right((response.data as List).map((e) => AdsModel.fromJson(e)).toList());
  }catch(e){
return left('f');
  }
}
  Future<Either<String,List<Brand>>> fetchBrands() async {
    try {
      final response = await dio.get(
        'https://evhubtl.com/wp-json/wp/v2/car-brand?per_page=100',
        options: Options(
          validateStatus: (status) => status! < 500, // Allow status codes less than 500
        ),
      );

      // log('Response Status Code: ${response.statusCode}');
      // log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return right ((response.data as List).map((brandData) => Brand.fromJson(brandData)).toList());
        } else {
          return left('Unexpected data format: Expected List but got ${response.data.runtimeType}');
         // throw Exception('Unexpected data format: Expected List but got ${response.data.runtimeType}');
        }
      } else {
        // throw Exception('Failed to load brands, status code: ${response.statusCode}');
        return left('Failed to load brands, status code: ${response.statusCode}');

      }
    } on DioException catch (e) {
      // log('DioException: ${e.message}');
      // throw Exception('Failed to load brands: ${e.message}');
      return left(e.message!);

    } catch (e) {
     // log('Error fetching brands: $e');
      throw Exception('Failed to load brands');
    }
  }
  Future<Either<String,List<Car>>> fetchCars() async {
    try {
      final response = await dio.get('/wp/v2/cars');
      List<Car> cars = (response.data as List)
          .map((car) => Car.fromMap(car))
          .toList();
      return right(cars);
    } on DioException catch (e) {
      return left(e.message!);
     // log('DioException: ${e.message}');
     // throw Exception('Failed to load cars: ${e.message}');
    } catch (e) {
      return left(e.toString());
      //log('Error fetching cars: $e');
     // throw Exception('Failed to load cars');
    }
  }

}