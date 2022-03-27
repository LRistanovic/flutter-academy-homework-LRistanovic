import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

import 'auth_info_holder.dart';
import 'interceptors.dart';

part 'network_repository.g.dart';

class NetworkRepository {
  AuthInfoHolder authInfoHolder;
  Dio dio = Dio();

  NetworkRepository({required this.authInfoHolder}) {
    dio.interceptors.addAll([AuthInfoInterceptor(authInfoHolder), ErrorExtractorInterceptor()]);
    dio.options.baseUrl = 'https://tv-shows.infinum.academy';
  }

  Future<User> registerUser({required AuthInfoHolder authInfoHolder}) async {
    final response = await dio.post('/users');
    final authInfo = AuthInfo.fromHeaderMap(response.headers.map);
    authInfoHolder.info = authInfo;
    print(response.data);
    return User.fromJson(response.data['user']);
  }
}

@JsonSerializable(createFactory: false)
class RegisterInfo {
  String? email;
  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);
}

class RegisterProvider extends RequestProvider<User> {
  final NetworkRepository _repository;
  RegisterProvider(this._repository);

  void attemptRegister({required AuthInfoHolder authInfoHolder}) {
    executeRequest(requestBuilder: () => _repository.registerUser(authInfoHolder: authInfoHolder));
  }
}

class LoginInfo {}

class LoginProvider extends RequestProvider<User> {
  final NetworkRepository _repository;
  LoginProvider(this._repository);
}

@JsonSerializable(createToJson: false)
class User {
  String? id;
  String? email;
  @JsonKey(name: 'image_url')
  String? imageUrl;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
