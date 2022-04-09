import 'package:flutter/animation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class UserProfileProvider extends RequestProvider {
  User user;
  NetworkRepository networkRepository;

  String? newEmail;

  XFile? _newImage;
  XFile? get newImagePath => _newImage;
  set newImage(XFile? val) {
    _newImage = val;
    notifyListeners();
  }

  AnimationController? pfpController;

  UserProfileProvider(this.networkRepository) : user = networkRepository.storageRepository.user!;

  void didSelectUpdateButton() {
    if (networkRepository.storageRepository.user!.email != newEmail && newEmail != null && _newImage != null) {
      executeRequest(
        requestBuilder: () => networkRepository.updateEmailAndImage(email: newEmail!, image: _newImage!),
      );
    } else if (networkRepository.storageRepository.user!.email != newEmail && newEmail != null) {
      executeRequest(requestBuilder: () => networkRepository.updateEmail(email: newEmail!));
    } else if (newImagePath != null) {
      executeRequest(requestBuilder: () => networkRepository.updateImage(image: _newImage!));
    }
  }
}
