import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/register/register_info.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class RegisterProvider extends RequestProvider<User> {
  final BuildContext context;

  RegisterProvider({required this.context});

  void didClickRegisterButton() {
    String email = context.read<CredentialsProvider>().email;
    String password = context.read<CredentialsProvider>().password;
    NetworkRepository repository = context.read<NetworkRepository>();

    executeRequest(
      requestBuilder: () => repository.registerUser(
        registerInfo: RegisterInfo(email: email, password: password),
      ),
    );
  }
}
