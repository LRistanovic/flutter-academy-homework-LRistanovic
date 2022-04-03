import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';

class LoginButton extends StatelessWidget {
  final Widget buttonContent;
  final void Function() buttonPressed;

  const LoginButton({Key? key, required this.buttonContent, required this.buttonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Consumer<CredentialsProvider>(
          builder: (context, provider, _) => ElevatedButton(
            onPressed: buttonPressed,
            child: buttonContent,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(provider.canLogin ? Colors.white : Colors.grey),
              overlayColor: MaterialStateProperty.all(
                const Color(0xffdbdbdb),
              ),
              foregroundColor: MaterialStateProperty.all(
                const Color(0xff52368C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
