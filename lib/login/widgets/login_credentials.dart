import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/credentials_provider.dart';

class LoginCredentials extends StatelessWidget {
  final String title;
  final String description;
  final String showOtherButtonTitle;
  final void Function() showOtherButtonPressed;

  const LoginCredentials({
    Key? key,
    required this.title,
    required this.description,
    required this.showOtherButtonTitle,
    required this.showOtherButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(description, style: const TextStyle(color: Colors.white), textAlign: TextAlign.left),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: TextField(
              key: const ValueKey('email field'),
              obscureText: false,
              autocorrect: false,
              style: const TextStyle(color: Colors.white),
              onChanged: (String val) {
                context.read<CredentialsProvider>().email = val;
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                hoverColor: Colors.white,
              ),
            ),
          ),
          Container(
            child: Consumer<CredentialsProvider>(
              builder: (context, provider, _) => TextField(
                key: const ValueKey('password field'),
                obscureText: !provider.isVisible,
                autocorrect: false,
                style: const TextStyle(color: Colors.white),
                onChanged: (String val) {
                  provider.password = val;
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  labelText: 'Password',
                  errorStyle: const TextStyle(color: Colors.red),
                  labelStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    icon: provider.isVisible
                        ? SvgPicture.asset('assets/images/visible.svg')
                        : SvgPicture.asset('assets/images/obscured.svg'),
                    onPressed: provider.changeVisibility,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: showOtherButtonPressed,
              child: Text(
                showOtherButtonTitle,
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
