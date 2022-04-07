import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/networking/auth_info.dart';
import 'package:tv_shows/networking/models/user.dart';

class StorageRepository {
  AuthInfo? _info;
  final storage = const FlutterSecureStorage();
  User? user;

  StorageRepository() {
    Hive.initFlutter();
  }

  Future<void> storeUserInfo(User _user, Map<String, List<String>> headerMap) async {
    final userBox = await Hive.openLazyBox('user');
    await userBox.put('user', _user.toJson());
    user = _user;
    setInfo(headerMap);
  }

  // zovu se getInfo i setInfo jer me nije pustilo
  // da se zovu isto a da imaju razlicite return type/argument type
  AuthInfo? get getInfo => _info;

  void setInfo(Map<String, List<String>> headerMap) {
    storage.write(key: 'access-token', value: headerMap['access-token']!.first);
    storage.write(key: 'client', value: headerMap['client']!.first);
    storage.write(key: 'token-type', value: headerMap['token-type']!.first);
    storage.write(key: 'uid', value: headerMap['uid']!.first);

    _info = AuthInfo.fromHeaderMap(headerMap);
  }

  Future<void> checkStorage() async {
    // AuthInfo in FlutterSecureStorage
    String? accessToken = await storage.read(key: 'access-token');
    String? client = await storage.read(key: 'client');
    String? tokenType = await storage.read(key: 'token-type');
    String? uid = await storage.read(key: 'uid');

    if (accessToken != null && client != null && tokenType != null && uid != null) {
      _info = AuthInfo(
        accessToken: accessToken,
        client: client,
        tokenType: tokenType,
        uid: uid,
      );
    }

    // User in Hive
    final userBox = await Hive.openLazyBox('user');
    if (await userBox.get('user') != null) {
      user = User.fromJson(Map<String, dynamic>.from(await userBox.get('user')));
    }
    userBox.close();
  }

  Future<void> deleteData() async {
    storage.delete(key: 'access-token');
    storage.delete(key: 'client');
    storage.delete(key: 'token-type');
    storage.delete(key: 'uid');

    final userBox = await Hive.openLazyBox('user');
    userBox.delete('user');
  }
}
