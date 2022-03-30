import 'package:dio/dio.dart';
import 'package:tv_shows/networking/errors/network_dio_error.dart';

class ErrorExtractorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final data = err.response?.data;
    if (data is! Map<String, dynamic>) {
      super.onError(err, handler);
    }
    final errors = data['errors'];
    if (errors is! List) {
      super.onError(err, handler);
    }
    final error = NetworkDioError(errorMessage: errors.join(', '), options: err.requestOptions);
    super.onError(error, handler);
  }
}
