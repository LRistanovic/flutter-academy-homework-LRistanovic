import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../networking/auth_info_holder.dart';
import 'state_provider.dart';
import 'widgets/login_button.dart';
import 'widgets/login_credentials.dart';
import 'widgets/upper_decoration.dart';

class BaseLoginScreen extends StatelessWidget {
  final String title;
  final String description;
  final String buttonTitle;
  final bool isLoading = false;
  final String showOtherButtonTitle;
  final void Function() buttonPressed;
  final void Function() showOtherButtonPressed;

  const BaseLoginScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonTitle,
    required this.showOtherButtonTitle,
    required this.buttonPressed,
    required this.showOtherButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff52368C),
      body: ChangeNotifierProvider<AuthInfoProvider>(
        create: (context) => AuthInfoProvider(),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: ChangeNotifierProvider<StateProvider>(
              create: (context) => StateProvider(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UpperDecoration(),
                  LoginCredentials(
                    title: title,
                    description: description,
                    showOtherButtonTitle: showOtherButtonTitle,
                    showOtherButtonPressed: showOtherButtonPressed,
                  ),
                  LoginButton(
                    buttonTitle: buttonTitle,
                    buttonPressed: buttonPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
