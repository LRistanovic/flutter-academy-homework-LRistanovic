import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

import 'show.dart';

class ShowsProvider extends RequestProvider {
  List<Show> shows = [];

  ShowsProvider(BuildContext context) {
    updateShows(context);
  }

  Future<void> updateShows(BuildContext context) async {
    executeRequest(requestBuilder: context.read<NetworkRepository>().fetchShows);
  }
}
