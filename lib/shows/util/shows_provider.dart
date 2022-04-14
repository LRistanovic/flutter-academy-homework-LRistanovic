import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_provider.dart';

import 'show.dart';

class ShowsProvider extends RequestProvider {
  List<Show> shows = [];

  ShowsProvider(NetworkRepository networkRepository) {
    updateShows(networkRepository);
  }

  Future<void> updateShows(NetworkRepository networkRepository) async {
    executeRequest(requestBuilder: networkRepository.fetchShows);
  }
}
