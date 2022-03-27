import 'package:flutter/material.dart';

import 'login/login_screen.dart';
import 'networking/auth_info_holder.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TV Shows',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(authInfoHolder: AuthInfoHolder()));
  }
}
