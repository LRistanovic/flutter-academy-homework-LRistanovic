import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/shows/util/show.dart';
import 'package:tv_shows/shows/util/shows_provider.dart';

import '../mocks.dart';

void main() {
  test('Fetch shows in the constructor', () {
    final networkRepository = MockNetworkRepository();
    when(networkRepository.fetchShows()).thenAnswer((_) async => <Show>[]);

    final showsProvider = ShowsProvider(networkRepository);

    verify(showsProvider.updateShows(networkRepository)).called(1);
  });
}
