import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_provider.dart';

class LoginButton extends StatelessWidget {
  final String buttonTitle;
  final void Function() buttonPressed;

  const LoginButton({Key? key, required this.buttonTitle, required this.buttonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Consumer<StateProvider>(
          builder: (context, provider, _) => ElevatedButton(
            onPressed: buttonPressed,
            child: Text(buttonTitle),
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
