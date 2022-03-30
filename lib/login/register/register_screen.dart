import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/register/register_provider.dart';

import '../base_login_screen.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CredentialsProvider(),
      child: ChangeNotifierProvider(
        create: (context) => RegisterProvider(context: context),
        child: Consumer<RegisterProvider>(
          builder: (context, registerProvider, _) {
            return BaseLoginScreen(
              title: 'Register',
              description: 'In order to continue please register.',
              buttonContent: registerProvider.state.maybeWhen(
                initial: () => const Text('Register'),
                loading: () => const CircularProgressIndicator(),
                orElse: () => const Text('This shouldn\'t happen'),
              ),
              showOtherButtonTitle: 'Sign in',
              buttonPressed: () {
                print('aaaaa');
                registerProvider.didClickRegisterButton();
              },
              showOtherButtonPressed: () {
                final route = MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                );
                Navigator.of(context).pushReplacement(route);
              },
            );
          },
        ),
      ),
    );
  }
}
