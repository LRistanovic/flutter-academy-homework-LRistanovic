import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/listener.dart';
import 'package:tv_shows/login/base_login_screen.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/login/login_screen.dart';
import 'package:tv_shows/login/register/register_provider.dart';
import 'package:tv_shows/login/welcome_screen.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';

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
            return ProviderListener<RegisterProvider>(
              listener: (context, registerProvider) {
                if (registerProvider.state is RequestStateSuccess) {
                  final route = MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(email: 'placeholder'),
                  );
                  Navigator.of(context).pushReplacement(route);
                } else if (registerProvider.state is RequestStateFailure) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('An error has occurred.'),
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
                title: 'Register',
                description: 'In order to continue please register.',
                buttonContent: registerProvider.state.maybeWhen(
                  initial: () => const Text('Register'),
                  loading: () => const CircularProgressIndicator(),
                  orElse: () => const Text('This shouldn\'t happen'),
                ),
                showOtherButtonTitle: 'Sign in',
                buttonPressed: registerProvider.didClickRegisterButton,
                showOtherButtonPressed: () {
                  final route = MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
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
