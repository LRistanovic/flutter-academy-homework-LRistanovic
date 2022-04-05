import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/login/login_screen.dart';
import 'package:tv_shows/shows/shows_screen.dart';

import 'networking/network_repository.dart';
import 'networking/storage_repository.dart';

class MyApp extends StatelessWidget {
  final StorageRepository storageRepository;

  const MyApp({required this.storageRepository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => NetworkRepository(storageRepository: storageRepository),
      child: MaterialApp(
        title: 'TV Shows',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: storageRepository.getInfo == null ? const LoginScreen() : const ShowsScreen(),
        // home: const LoginScreen(),
      ),
    );
  }
}
