import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_error_model.dart';
import 'package:evhub/core/networking/error_handler.dart';
import 'package:evhub/features/home/data/model/car_model.dart';

class MyCars{
  Dio dio;
  MyCars(this.dio);
  Future<Either<ApiErrorModel, List<Car>>> getCars() async {
    try {
      final responses = await Future.wait([
        dio.get('/wp/v2/cars?author=12526'),
        dio.get('/wp/v2/cars?status=pending&author=12526'),
      ]);

      final cars1 = (responses[0].data as List)
          .map((car) => Car.fromMap(car))
          .toList();

      final cars2 = (responses[1].data as List)
          .map((car) => Car.fromMap(car))
          .toList();

      final combinedCars = [...cars1, ...cars2];

      // Optional: remove duplicates by ID
      final uniqueCars = {
        for (var car in combinedCars) car.id!: car,
      }.values.toList();

      return right(uniqueCars);
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<ApiErrorModel,List<Car>>> getPendingCars()async{
    try{
      var response =await dio.get('/wp/v2/cars?status=published&author=12526');
      List<Car> cars = (response.data as List)
          .map((car) => Car.fromMap(car))
          .toList();
      return right(cars);
    }catch(e){
      return left(ApiErrorHandler.handle(e));
    }
  }
  Future<Either<String,String>> deleteCar(int carId)async{
    try{
      var response =await dio.delete('/wp/v2/cars/$carId',queryParameters: {'force':true});
      // List<Car> cars = (response.data as List)
      //     .map((car) => Car.fromMap(car))
      //     .toList();
      print(response.data);
      return right('deleted');
    }catch(e){
      return left('error');
    }
  }
}
// can i do two api and return one list  Future<Either<ApiErrorModel,List<Car>>> getCars()async{
//   try{
//     var response =await dio.get('/wp/v2/cars?author=127');
//     List<Car> cars = (response.data as List)
//         .map((car) => Car.fromMap(car))
//         .toList();
//     return right(cars);
//   }catch(e){
//     return left(ApiErrorHandler.handle(e));
//   }
// } with https://evhubtl.com/wp-json/wp/v2/cars?status=published&author=127