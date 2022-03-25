import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/welcome_screen.dart';

import '../state_provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Consumer<StateProvider>(
                builder: (context, provider, _) => ElevatedButton(
                      onPressed: provider.canLogin
                          ? () {
                              final route =
                                  MaterialPageRoute(builder: (context) => WelcomeScreen(email: provider.email));
                              Navigator.of(context).pushReplacement(route);
                            }
                          : null,
                      child: const Text('Login'),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                          backgroundColor: MaterialStateProperty.all(provider.canLogin ? Colors.white : Colors.grey),
                          overlayColor: MaterialStateProperty.all(const Color(0xffdbdbdb)),
                          foregroundColor: MaterialStateProperty.all(const Color(0xff52368C))),
                    ))));
  }
}
