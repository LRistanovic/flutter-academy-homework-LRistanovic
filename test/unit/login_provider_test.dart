import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/login/credentials_provider.dart';
import 'package:tv_shows/login/login/login_provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';
import 'package:tv_shows/networking/storage_repository.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';

import '../mocks.dart';

@GenerateMocks([NetworkRepository, StorageRepository, CredentialsProvider, ReviewsProvider])
void main() {
  test('Logging in works properly', () async {
    final networkRepository = MockNetworkRepository();
    final credentialsProvider = MockCredentialsProvider();
    when(networkRepository.signinUser(signinInfo: anyNamed('signinInfo'))).thenAnswer((_) async => User('id', 'email'));
    when(credentialsProvider.email).thenReturn('email');
    when(credentialsProvider.password).thenReturn('password');

    final loginProvider = LoginProvider(credentialsProvider: credentialsProvider, networkRepository: networkRepository);
    loginProvider.didClickLoginButton();

    expect(loginProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(loginProvider.state is RequestStateSuccess, true);
  });
}
