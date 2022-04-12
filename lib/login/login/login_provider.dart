import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/login/signin_info.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class LoginProvider extends RequestProvider<User> {
  final NetworkRepository networkRepository;
  final CredentialsProvider credentialsProvider;

  LoginProvider({required this.networkRepository, required this.credentialsProvider});

  void didClickLoginButton() {
    String email = credentialsProvider.email;
    String password = credentialsProvider.password;

    executeRequest(
      requestBuilder: () => networkRepository.signinUser(
        signinInfo: SigninInfo(email: email, password: password),
      ),
    );
  }
}
