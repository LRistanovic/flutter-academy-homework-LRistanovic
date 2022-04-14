import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/networking/storage_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final storageRepository = StorageRepository();
  await storageRepository.checkStorage();

  runApp(MyApp(
    storageRepository: storageRepository,
  ));
}
