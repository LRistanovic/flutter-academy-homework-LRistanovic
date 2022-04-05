import 'package:tv_shows/networking/auth_info.dart';

class AuthInfoHolder {
  AuthInfo? _info;

  AuthInfo? get info {
    if (_info != null) {
      return _info;
    }
  }
}
