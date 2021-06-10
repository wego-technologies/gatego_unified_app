import 'dart:convert';

import 'package:gatego_unified_app/models/account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

Future<String?> getJWT(String user, String pass) async {
  var res = await http.post(
      Uri(
        host: "api.gatego.io",
        scheme: "https",
        path: "auth/login",
      ),
      body: jsonEncode(
        {
          "username": user,
          "password": pass,
        },
      ),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body) as Map<String, dynamic>;
    return json["jwt_token"];
  } else {
    print(res);
    return null;
  }
}

Future<String?> refreshJWT(String jwt) async {
  var res = await http.post(
      Uri(
        host: "api.gatego.io",
        scheme: "https",
        path: "auth/refresh-token",
      ),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer " + jwt,
      });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body) as Map<String, dynamic>;
    return json["jwt_token"];
  } else {
    print(res);
    return null;
  }
}

Future<Account?> getAccount() async {
  return null;
}

//Account getAccount(String jwt) {}

final jwtProvider = StateProvider.autoDispose<String?>((ref) {
  return "";
});

final accountProvider = StateProvider.autoDispose<Account?>((ref) {});
