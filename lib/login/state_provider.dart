import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  void changeVisibility() {
    _isVisible = _isVisible ? false : true;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(val) {
    if (_email != val) {
      _email = val;
      notifyListeners();
    }
  }

  String _password = '';
  set password(val) {
    if (_password != val) {
      _password = val;
      notifyListeners();
    }
  }

  bool get canLogin => _email != '' && _password != '';
}
