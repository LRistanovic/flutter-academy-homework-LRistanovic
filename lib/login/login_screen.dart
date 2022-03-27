import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/auth_info_holder.dart';
import 'package:tv_shows/networking/network_repository.dart';

import 'base_login_screen.dart';
import 'register_screen.dart';

// class LoginScreen extends BaseLoginScreen {
//   LoginScreen(BuildContext context, {Key? key})
//       : super(
//             key: key,
//             title: 'Login',
//             description: 'In order to continue please log in.',
//             buttonTitle: 'Login',
//             showOtherButtonTitle: 'Create account',
//             buttonPressed: () {},
//             showOtherButtonPressed: () {
//               final route = MaterialPageRoute(builder: (context) => RegisterScreen(context));
//               Navigator.of(context).pushReplacement(route);
//             });
// }

class LoginScreen extends StatelessWidget {
  final AuthInfoHolder authInfoHolder;
  const LoginScreen({required this.authInfoHolder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(
        NetworkRepository(authInfoHolder: authInfoHolder),
      ),
      child: BaseLoginScreen(
        title: 'Login',
        description: 'In order to continue please log in.',
        buttonTitle: 'Login',
        showOtherButtonTitle: 'Create account',
        buttonPressed: () => {context.read<RegisterProvider>().attemptRegister(authInfoHolder: authInfoHolder)},
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => RegisterScreen(
              authInfoHolder: authInfoHolder,
            ),
          );
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
