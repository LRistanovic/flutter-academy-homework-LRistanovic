import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/auth_info_holder.dart';
import 'package:tv_shows/networking/network_repository.dart';

import 'base_login_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final AuthInfoHolder authInfoHolder;

  const RegisterScreen({required this.authInfoHolder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(
        NetworkRepository(authInfoHolder: authInfoHolder),
      ),
      child: BaseLoginScreen(
        title: 'Register',
        description: 'In order to continue please register.',
        buttonTitle: 'Register',
        showOtherButtonTitle: 'Sign in',
        buttonPressed: () {
          context.read<RegisterProvider>().attemptRegister(authInfoHolder: authInfoHolder);
        },
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => LoginScreen(authInfoHolder: authInfoHolder),
          );
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
