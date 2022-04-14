import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/listener.dart';
import 'package:tv_shows/login/base_login_screen.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/login/login_provider.dart';
import 'package:tv_shows/login/register/register_screen.dart';
import 'package:tv_shows/login/welcome_screen.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CredentialsProvider(),
      child: Consumer<CredentialsProvider>(
        builder: (context, credentialsProvider, _) {
          return ChangeNotifierProvider(
            create: (context) => LoginProvider(
              networkRepository: context.read<NetworkRepository>(),
              credentialsProvider: context.read<CredentialsProvider>(),
            ),
            child: Consumer<LoginProvider>(
              builder: (context, loginProvider, _) {
                return ProviderListener<LoginProvider>(
                  listener: (context, loginProvider) {
                    if (loginProvider.state is RequestStateSuccess) {
                      final route = MaterialPageRoute(
                        builder: (context) => WelcomeScreen(email: credentialsProvider.email),
                      );
                      Navigator.of(context).pushReplacement(route);
                    } else if (loginProvider.state is RequestStateFailure) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                              loginProvider.state.maybeWhen(failure: (error) => error.toString(), orElse: () => ''),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: BaseLoginScreen(
                    title: 'Login',
                    description: 'In order to continue please log in.',
                    buttonContent: context.watch<LoginProvider>().state.maybeWhen(
                          loading: () => const CircularProgressIndicator(),
                          orElse: () => const Text('Login'),
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
          );
        },
      ),
    );
  }
}
