import 'package:dio/dio.dart';

import 'auth_info_holder.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoHolder holder;
  AuthInfoInterceptor(this.holder);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (holder.info != null) {
      options.headers.addAll(holder.info!.toHeaders());
    }
    super.onRequest(options, handler);
  }
}

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

class NetworkDioError extends DioError {
  NetworkDioError({required RequestOptions options, required this.errorMessage})
      : super(requestOptions: options, error: Exception(errorMessage));
  final String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}
