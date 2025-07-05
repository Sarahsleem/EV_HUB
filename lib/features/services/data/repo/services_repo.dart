import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/core/networking/error_handler.dart';
import 'package:evhub/features/services/data/model/add_review_model.dart';
import 'package:evhub/features/add_services/data/models/service_model.dart';

import '../model/car_acc_model.dart';
import '../model/car_part_model.dart';
import '../model/car_protetion_file.dart';
import '../model/establishingCharging.dart';
import '../model/insurance_model.dart';
import '../model/service_model.dart';
import '../model/solar_model.dart';

class Services{
  Dio dio;
  Services(this.dio);
   Future<Either<ApiErrorModel, Insurance>> createInsuranceService(
      CompanyInfo insuranceData) async {
    try {
      // Note: Creating posts in WordPress typically requires authentication (e.g., a JWT token).
      // Ensure your Dio instance is configured with the necessary auth headers.
      final response = await dio.post(
        'wp/v2/insurance', // Endpoint for creating a new insurance entry
        data: insuranceData.toJson(), // The data to be sent, converted to JSON
      );

      // On successful creation (HTTP 201), the API returns the newly created object.
      // We parse it using the existing Insurance.fromJson model.
      return right(Insurance.fromJson(response.data));
    } catch (e) {
      // Handle any errors that occur during the request
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel,List<ServiceCenter>>> fetchServiceCenters() async {
    try {
      final response = await dio.get(
        ApiConstants.carServices
      );


      if (response.data == null) {
        //log('Error: Received null response from API');
        throw Exception('No data available');
      }

      if (response.data is! List) {
        //log('Error: API response is not a list');
        throw Exception('Invalid data format received from API');
      }

      List<ServiceCenter> serviceCenters =
      (response.data as List)
          .map((center) => ServiceCenter.fromJson(center as Map<String, dynamic>))
          .toList();

      return right(serviceCenters);
    }  catch (e) {
     // throw Exception('Failed to load service centers');
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,String>> postComment(AddReviewModel addReview) async {
    var formData = FormData.fromMap(addReview.toMap());
    try {
      final response = await dio.post('wp/v2/comments', data: formData);
      return right(response.data);
    }  catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,List<CarAccessories>>> fetchCarAccessories() async {
    try {
      final response = await dio.get('wp/v2/car-accessories');

      List<CarAccessories> parts = (response.data as List)
          .map((part) => CarAccessories.fromJson(part))
          .toList();
print(parts);
      return right(parts);
    } catch (e) {
      print(e);
      return left(ApiErrorHandler.handle(e));
     // log('Error fetching car parts: $e');
      throw Exception('Failed to loadCarAccessories');
    }
  }

  Future<Either<ApiErrorModel,List<SolarEnergy>>> fetchSolarEnergy() async {
    try {
      final response = await dio.get('https://evhubtl.com/wp-json/wp/v2/solar-energy');

      List<SolarEnergy> solarEnergy = (response.data as List)
          .map((part) => SolarEnergy.fromJson(part))
          .toList();

      return right(solarEnergy);
    }  catch (e) {
     return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel,List<EstablishingCharging>>> fetchEstablishingCharging() async {
    try {
      final response = await dio.get('wp/v2/establishing-chargin?_embed');

      List<EstablishingCharging> films = (response.data as List)
          .map((film) => EstablishingCharging.fromJson(film))
          .toList();

      return right(films);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,List<Insurance>>> fetchInsurance() async {
    try {
      // Fetch data from the API
      final response = await dio.get(
          'wp/v2/insurance');

      List<Insurance> films = (response.data as List)
          .map((film) => Insurance.fromJson(film))
          .toList();
return right(films);
    } catch (e) {
print(e);
     return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel,List<CarProtectionFilm>>> fetchCarProtectionFilms() async {
    try {
      final response = await dio.get('https://evhubtl.com/wp-json/wp/v2/car-protection-film?_embed');

      List<CarProtectionFilm> films = (response.data as List)
          .map((film) => CarProtectionFilm.fromJson(film))
          .toList();

      return right(films);
    } catch (e) {
     return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,List<CarParts>>> fetchCarParts() async {
    try {
      final response = await dio.get('wp/v2/car-parts');

      List<CarParts> parts = (response.data as List)
          .map((part) => CarParts.fromJson(part))
          .toList();

      return right(parts);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}