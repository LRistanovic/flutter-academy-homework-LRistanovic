import 'package:flutter/material.dart';
import 'package:tv_shows/networking/storage_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageRepository = StorageRepository();
  await storageRepository.checkStorage();

  runApp(MyApp(
    storageRepository: storageRepository,
  ));
}
