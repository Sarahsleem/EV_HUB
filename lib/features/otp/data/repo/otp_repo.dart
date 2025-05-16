import 'package:dio/dio.dart';
import 'package:evhub/core/networking/api_constants.dart';
import 'package:evhub/features/otp/data/model/otp_model.dart';

class OTPRepo {
  Dio dio;
  OTPRepo({required this.dio});
  Future<String> sendOTP({required OTPModel otpmodel}) async {
    try {
  var response=  await  dio.post(ApiConstants.otp, data: otpmodel.toMap());
return "success";
    } catch (e) {
      return e.toString();
    }
  }
}