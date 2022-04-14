import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';
import 'package:tv_shows/shows/util/user_profile_provider.dart';

import '../mocks.dart';

void main() {
  test('Update email works properly', () async {
    final networkRepository = MockNetworkRepository();
    final storageRepository = MockStorageRepository();
    when(networkRepository.updateEmail(email: anyNamed('email'))).thenAnswer((_) async => User('a', 'b'));
    when(networkRepository.storageRepository).thenReturn(storageRepository);
    when(storageRepository.user).thenReturn(User('id', 'email'));

    final userProfileProvider = UserProfileProvider(networkRepository);
    userProfileProvider.newEmail = 'new email';
    userProfileProvider.didSelectUpdateButton();

    expect(userProfileProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(userProfileProvider.state is RequestStateSuccess, true);
  });

  test('Update doesn\'t execute when email isn\'t changed', () async {
    final networkRepository = MockNetworkRepository();
    final storageRepository = MockStorageRepository();
    when(networkRepository.updateEmail(email: anyNamed('email'))).thenAnswer((_) async => User('a', 'b'));
    when(networkRepository.storageRepository).thenReturn(storageRepository);
    when(storageRepository.user).thenReturn(User('id', 'email'));

    final userProfileProvider = UserProfileProvider(networkRepository);
    userProfileProvider.newEmail = 'email';
    userProfileProvider.didSelectUpdateButton();

    expect(userProfileProvider.state is RequestStateInitial, true);
  });

  test('Update image works properly', () async {
    final networkRepository = MockNetworkRepository();
    final storageRepository = MockStorageRepository();
    when(networkRepository.updateImage(image: anyNamed('image'))).thenAnswer((_) async => User('a', 'b'));
    when(networkRepository.storageRepository).thenReturn(storageRepository);
    when(storageRepository.user).thenReturn(User('id', 'email'));

    final userProfileProvider = UserProfileProvider(networkRepository);
    userProfileProvider.newImage = XFile('new image path');
    userProfileProvider.didSelectUpdateButton();

    expect(userProfileProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(userProfileProvider.state is RequestStateSuccess, true);
  });

  test('Update email and image works properly', () async {
    final networkRepository = MockNetworkRepository();
    final storageRepository = MockStorageRepository();
    when(networkRepository.updateEmailAndImage(email: anyNamed('email'), image: anyNamed('image')))
        .thenAnswer((_) async => User('a', 'b'));
    when(networkRepository.storageRepository).thenReturn(storageRepository);
    when(storageRepository.user).thenReturn(User('id', 'email'));

    final userProfileProvider = UserProfileProvider(networkRepository);
    userProfileProvider.newEmail = 'new email';
    userProfileProvider.newImage = XFile('path');
    userProfileProvider.didSelectUpdateButton();

    expect(userProfileProvider.state is RequestStateLoading, true);
    await Future.delayed(const Duration(milliseconds: 10));
    expect(userProfileProvider.state is RequestStateSuccess, true);
  });
}
