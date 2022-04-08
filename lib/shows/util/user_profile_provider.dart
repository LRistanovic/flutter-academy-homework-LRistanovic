import 'package:flutter/animation.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class UserProfileProvider extends RequestProvider {
  User user;
  NetworkRepository networkRepository;

  String? newEmail;

  String? _newImagePath;
  String? get newImagePath => _newImagePath;
  set newImagePath(String? val) {
    _newImagePath = val;
    notifyListeners();
  }

  AnimationController? pfpController;

  UserProfileProvider(this.networkRepository) : user = networkRepository.storageRepository.user!;

  void didSelectUpdateButton() {
    if (networkRepository.storageRepository.user!.email != newEmail && newEmail != null && newImagePath != null) {
      executeRequest(
        requestBuilder: () => networkRepository.updateEmailAndImage(email: newEmail!, imagePath: newImagePath!),
      );
    } else if (networkRepository.storageRepository.user!.email != newEmail && newEmail != null) {
      executeRequest(requestBuilder: () => networkRepository.updateEmail(email: newEmail!));
    } else if (newImagePath != null) {
      executeRequest(requestBuilder: () => networkRepository.updateImage(imagePath: newImagePath!));
    }
  }
}
