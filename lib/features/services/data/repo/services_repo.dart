import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/core/networking/error_handler.dart';

import '../model/service_model.dart';

class Services{
  Dio dio;
  Services(this.dio);
  Future<Either<ApiErrorModel,List<ServiceCenter>>> fetchServiceCenters() async {
    try {
      final response = await dio.get(
        ApiConstants.carServices
      );

      // طباعة استجابة السيرفر لمزيد من التصحيح
      //   log('Response Data: ${response.data}');

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

}