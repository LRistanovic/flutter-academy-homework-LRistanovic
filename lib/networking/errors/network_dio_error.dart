import 'package:dio/dio.dart';

class NetworkDioError extends DioError {
  NetworkDioError({required RequestOptions options, required this.errorMessage})
      : super(requestOptions: options, error: Exception(errorMessage));
  final String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}
