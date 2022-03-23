import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state_provider.dart';
import 'widgets/credentials.dart';
import 'widgets/login_button.dart';
import 'widgets/upper_decoration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff52368C),
        body: SingleChildScrollView(
            child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: ChangeNotifierProvider<StateProvider>(
              create: (context) => StateProvider(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [UpperDecoration(), Credentials(), LoginButton()])),
        )));
  }
}
