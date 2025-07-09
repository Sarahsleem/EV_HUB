
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../../../core/networking/error_handler.dart';
import '../model/car_brand.dart';
import '../model/car_model.dart';
import '../model/company_model.dart';
List<Brand> parseBrands(List<dynamic> data) {
  return data.map((e) => Brand.fromJson(e)).toList();
}

class HomeRepo{
  Dio dio;
  HomeRepo(this.dio);
  Future<Either<ApiErrorModel,List<Car>>> getCarsByAuthor(String authorId)async{

    try{
      var response =await dio.get('/wp/v2/cars?status=published&author=$authorId');
      List<Car> cars = (response.data as List)
          .map((car) => Car.fromMap(car))
          .toList();
      return right(cars);
    }catch(e){
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,List<Car>>> searchCars({
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


   Future<List<Car>> fetchCarsByAuthor(int authorId) async {
    try {
      final response = await dio.get(
       ApiConstants.cars,
        queryParameters: {'author': authorId},
        options: Options(
          validateStatus: (status) => status! < 500, // السماح بأكواد أقل من 500
        ),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return response.data.map<Car>((car) => Car.fromMap(car)).toList();
        } else {
          throw Exception('Unexpected data format: Expected List but got ${response.data.runtimeType}');
        }
      } else {
        throw Exception('Failed to load cars, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}');
      throw Exception('Failed to load cars: ${e.message}');
    } catch (e) {
      log('Error fetching cars: $e');
      throw Exception('Failed to load cars');
    }
  }
 
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
  print(e);
return left('f');
  }
}
  Future<Either<String, List<Brand>>> fetchBrands(int count) async {
    try {
      final response = await dio.get(
        'https://evhubtl.com/wp-json/wp/v2/car-brand?per_page=$count',
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<dynamic> rawData = response.data;
          final parsed = await compute(parseBrands, rawData); // 🚀 compute
          return right(parsed);
        } else {
          return left('Unexpected data format: Expected List but got ${response.data.runtimeType}');
        }
      } else {
        return left('Failed to load brands, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return left(e.message ?? 'Unknown Dio error');
    } catch (e) {
      return left('Failed to load brands');
    }
  }
  Future<Either<String,List<Car>>> fetchCars() async {
    try {
      final response = await dio.get('/wp/v2/cars?per_page=7');
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
  Future<Either<String, List<CompanyModel>>> fetchUsersByRole(String role) async {
    try {
      final response = await dio.get(
        'http://evhubtl.com/wp-json/custom/v1/users-by-role',
        queryParameters: {'role': role},
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          List<CompanyModel> users = (response.data as List)
              .map((userJson) => CompanyModel.fromJson(userJson))
              .toList();
          return right(users);
        } else {
          return left(
              'Unexpected response format: Expected List but got ${response.data.runtimeType}');
        }
      } else {
        return left('Failed to load users, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}');
      return left(e.message ?? 'DioException occurred');
    } catch (e) {
      log('Error fetching users: $e');
      return left(e.toString());
    }
  }


}