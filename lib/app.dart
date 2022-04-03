import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/login/login_screen.dart';

import 'networking/auth_info_holder.dart';
import 'networking/network_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthInfoHolder(),
      child: Consumer<AuthInfoHolder>(
        builder: (context, authInfoHolder, _) {
          return Provider(
            create: (context) => NetworkRepository(authInfoHolder: authInfoHolder),
            child: MaterialApp(
              title: 'TV Shows',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
