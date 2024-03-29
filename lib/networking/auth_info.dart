import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInfo {
  AuthInfo({required this.accessToken, required this.client, required this.tokenType, required this.uid});

  final String accessToken;
  final String client;
  final String tokenType;
  final String uid;

  final storage = const FlutterSecureStorage();

  factory AuthInfo.fromHeaderMap(Map<String, List<String>> headerMap) {
    return AuthInfo(
      accessToken: headerMap['access-token']!.first,
      client: headerMap['client']!.first,
      tokenType: headerMap['token-type']!.first,
      uid: headerMap['uid']!.first,
    );
  }

  Map<String, String> toHeaders() {
    return {
      'access-token': accessToken,
      'client': client,
      'token-type': tokenType,
      'uid': uid,
    };
  }
}
