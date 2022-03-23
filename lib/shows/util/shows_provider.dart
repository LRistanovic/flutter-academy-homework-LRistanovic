import 'package:flutter/material.dart';

import 'show.dart';

class ShowsProvider with ChangeNotifier {
  final List<Show> shows = Show.allShows;
  bool _areShowsAvailable = true;

  bool get areShowsAvailable => _areShowsAvailable;
  set areShowsAvailable(bool newVal) {
    _areShowsAvailable = newVal;
    notifyListeners();
  }
}
