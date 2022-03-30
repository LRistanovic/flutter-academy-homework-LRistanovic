import 'package:dio/dio.dart';
import 'package:tv_shows/networking/auth_info_holder.dart';

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
