import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tv_shows/shows/shows_screen.dart';

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
      final route = MaterialPageRoute(builder: (context) => const ShowsScreen());
      Navigator.of(context).pushReplacement(route);
    });

    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.all(20), child: SvgPicture.asset('assets/images/welcomeicon.svg')),
                Text(
                  'Welcome, $username!',
                  style: const TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Lottie.asset('assets/lottie/tv.json', height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
