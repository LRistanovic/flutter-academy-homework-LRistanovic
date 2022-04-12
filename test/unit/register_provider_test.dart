import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/login/register/register_provider.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';

import '../mocks.dart';

void main() {
  test('Registering works properly', () async {
    final networkRepository = MockNetworkRepository();
    final credentialsProvider = MockCredentialsProvider();
    when(networkRepository.registerUser(registerInfo: anyNamed('registerInfo')))
        .thenAnswer((_) async => User('id', 'email'));
    when(credentialsProvider.email).thenReturn('email');
    when(credentialsProvider.password).thenReturn('password');

    final registerProvider = RegisterProvider(
      credentialsProvider: credentialsProvider,
      networkRepository: networkRepository,
    );
    registerProvider.didClickRegisterButton();

    expect(registerProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(registerProvider.state is RequestStateSuccess, true);
  });
}
