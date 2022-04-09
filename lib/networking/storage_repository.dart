import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/networking/auth_info.dart';
import 'package:tv_shows/networking/models/user.dart';

class StorageRepository extends ChangeNotifier {
  AuthInfo? _info;
  final storage = const FlutterSecureStorage();
  User? user;

  Future<void> storeUserInfo(User _user, Map<String, List<String>> headerMap) async {
    final userBox = await Hive.openLazyBox('user');
    await userBox.put('user', _user.toJson());
    user = _user;
    setInfo(AuthInfo.fromHeaderMap(headerMap));
    notifyListeners();
  }

  // zovu se getInfo i setInfo jer me nije pustilo
  // da se zovu isto a da imaju razlicite return type/argument type
  AuthInfo? get getInfo => _info;

  void setInfo(AuthInfo authInfo) {
    storage.write(key: 'access-token', value: authInfo.accessToken);
    storage.write(key: 'client', value: authInfo.client);
    storage.write(key: 'token-type', value: authInfo.tokenType);
    storage.write(key: 'uid', value: authInfo.uid);

    _info = authInfo;
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
    final userObject = await userBox.get('user');
    if (userObject != null) {
      user = User.fromJson(Map<String, dynamic>.from(userObject));
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
