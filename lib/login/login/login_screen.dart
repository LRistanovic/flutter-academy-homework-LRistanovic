import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/listener.dart';
import 'package:tv_shows/login/base_login_screen.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/register/register_screen.dart';
import 'package:tv_shows/login/welcome_screen.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';

import 'login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CredentialsProvider(),
      child: ChangeNotifierProvider(
        create: (context) => LoginProvider(context: context),
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, _) {
            return ProviderListener<LoginProvider>(
              listener: (context, loginProvider) {
                if (loginProvider.state is RequestStateSuccess) {
                  final route = MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(email: 'placeholder'),
                  );
                  Navigator.of(context).pushReplacement(route);
                } else if (loginProvider.state is RequestStateFailure) {}
              },
              child: BaseLoginScreen(
                title: 'Login',
                description: 'In order to continue please log in.',
                buttonContent: context.watch<LoginProvider>().state.maybeWhen(
                      initial: () => const Text('Login'),
                      loading: () => const CircularProgressIndicator(),
                      orElse: () => Container(),
                    ),
                showOtherButtonTitle: 'Create account',
                buttonPressed: loginProvider.didClickLoginButton,
                showOtherButtonPressed: () {
                  final route = MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  );
                  Navigator.of(context).pushReplacement(route);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
