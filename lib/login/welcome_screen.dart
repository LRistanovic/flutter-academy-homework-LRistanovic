import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shows/shows_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String email;
  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = '';
    for (int i = 0; i < email.length; i++) {
      if (email[i] == '@') {
        break;
      }
      username += email[i];
    }

    Future.delayed(const Duration(seconds: 1), () {
      final route = MaterialPageRoute(builder: (context) => ShowsScreen());
      Navigator.of(context).pushReplacement(route);
    });

    return MaterialApp(
        home: Scaffold(
            body: Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(20), child: SvgPicture.asset('assets/images/welcomeicon.svg')),
                      Text('Welcome, $username!',
                          style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold))
                    ]))));
  }
}
