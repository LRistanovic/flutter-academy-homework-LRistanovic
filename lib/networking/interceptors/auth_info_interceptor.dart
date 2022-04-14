import 'package:dio/dio.dart';
import 'package:tv_shows/networking/storage_repository.dart';

class AuthInfoInterceptor extends Interceptor {
  StorageRepository holder;
  AuthInfoInterceptor(this.holder);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (holder.getInfo != null) {
      options.headers.addAll(holder.getInfo!.toHeaders());
    }
    super.onRequest(options, handler);
  }
}
