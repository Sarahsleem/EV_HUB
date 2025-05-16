import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/features/home/data/model/Ads_model.dart';

class HomeRepo{
  Dio dio;
  HomeRepo(this.dio);
  Future<Either<String,List<AdsModel>>> getADS()async{
try{
  var response =await dio.get(ApiConstants.ads);
  return right((response.data as List).map((e) => AdsModel.fromJson(e)).toList());
  }catch(e){
return left('f');
  }
}
}