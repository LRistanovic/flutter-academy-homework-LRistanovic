import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

import 'signin_info.dart';

class LoginProvider extends RequestProvider<User> {
  final BuildContext context;

  LoginProvider({required this.context});

  void didClickLoginButton() {
    NetworkRepository repository = context.read<NetworkRepository>();
    String email = context.read<CredentialsProvider>().email;
    String password = context.read<CredentialsProvider>().password;

    executeRequest(
      requestBuilder: () => repository.signinUser(
        signinInfo: SigninInfo(email: email, password: password),
      ),
    );
  }
}
