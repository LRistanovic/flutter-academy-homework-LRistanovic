import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/login/credentials_provider.dart';

void main() {
  test('Initially password is obscured', () {
    final credentialsProvider = CredentialsProvider();

    expect(credentialsProvider.isVisible, false);
  });

  test('Password visibility changes', () {
    final credentialsProvider = CredentialsProvider();
    credentialsProvider.changeVisibility();

    expect(credentialsProvider.isVisible, true);
  });

  test('Can log in works', () {
    final credentialsProvider = CredentialsProvider();
    credentialsProvider.email = 'email';
    credentialsProvider.password = 'password';

    expect(credentialsProvider.canLogin, true);
  });

  test('Can\'t log in works', () {
    final credentialsProvider = CredentialsProvider();
    credentialsProvider.email = '';
    credentialsProvider.password = 'password';

    expect(credentialsProvider.canLogin, false);
  });

  test('Can\'t log in works', () {
    final credentialsProvider = CredentialsProvider();
    credentialsProvider.email = 'email';
    credentialsProvider.password = '';

    expect(credentialsProvider.canLogin, false);
  });
}
