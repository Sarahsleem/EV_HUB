import 'package:dio/dio.dart';

import '../../ev_hub.dart';
import '../../generated/l10n.dart';
import 'api_error_model.dart';


class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .connectionToServerFailed);
        case DioExceptionType.cancel:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .requestToTheServerWasCancelled);
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .connectionTimeoutWithTheServer);
        case DioExceptionType.unknown:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .connectionToTheServerFailedDueToInternetConnection);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .receiveTimeOutInConnectionWithTheServer);
        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .sendTimeoutInConnectionWithTheServer);
        default:
          return ApiErrorModel(
              message: S
                  .of(NavigationService.navigatorKey.currentContext!)
                  .somethingWentWrong);
      }
    } else {
      return ApiErrorModel(
          message: S
              .of(NavigationService.navigatorKey.currentContext!)
              .UnexpectedErrorOccurred);
    }
  }

  static ApiErrorModel _handleError(int? statusCode, dynamic error) {
    return ApiErrorModel(
      message: error['message'] ??
          S.of(NavigationService.navigatorKey.currentContext!)
              .UnexpectedErrorOccurred,
      code: statusCode,
      errors: error['data'],
    );
  }
}
