import 'package:tv_shows/networking/models/user.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

class UserProfileProvider extends RequestProvider {
  User user;
  NetworkRepository networkRepository;

  String newEmail = '';

  UserProfileProvider(this.networkRepository) : user = networkRepository.storageRepository.user!;

  void didSelectUpdateButton(String newEmail) {
    if (networkRepository.storageRepository.user!.email == newEmail) {
      return;
    }

    executeRequest(requestBuilder: () => networkRepository.updateEmail(email: newEmail));
  }

  void didUpdateProfilePicture(String newImagePath, String newEmail) {
    if (networkRepository.storageRepository.user!.email == newEmail) {
      return;
    }

    executeRequest(
        requestBuilder: () => networkRepository.updateEmailAndImage(email: newEmail, imagePath: newImagePath));
  }
}
