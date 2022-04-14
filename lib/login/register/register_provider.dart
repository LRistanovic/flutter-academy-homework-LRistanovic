import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/register/register_info.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class RegisterProvider extends RequestProvider<User> {
  final NetworkRepository networkRepository;
  final CredentialsProvider credentialsProvider;

  RegisterProvider({required this.networkRepository, required this.credentialsProvider});

  void didClickRegisterButton() {
    String email = credentialsProvider.email;
    String password = credentialsProvider.password;

    executeRequest(
      requestBuilder: () => networkRepository.registerUser(
        registerInfo: RegisterInfo(email: email, password: password),
      ),
    );
  }
}
