import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gatego_unified_app/models/account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AccountProvider extends ChangeNotifier {
  Account? acc;
  String? jwt;
  Timer? refTimer;

  Future<String?> getJWT(String user, String pass) async {
    var res = await http.post(
        Uri(
          host: 'api.gatego.io',
          scheme: 'https',
          path: 'auth/login',
        ),
        body: jsonEncode(
          {
            'username': user,
            'password': pass,
          },
        ),
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json'
        });

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      jwt = json['jwt_token'];
      return json['jwt_token'];
    } else {
      print(res.statusCode);
      return null;
    }
  }

  Future<String?> refreshJWT(String jwt) async {
    var res = await http.post(
        Uri(
          host: 'api.gatego.io',
          scheme: 'https',
          path: 'auth/refresh-token',
        ),
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + jwt,
        });

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      jwt = json['jwt_token'];
      return json['jwt_token'];
    } else {
      print(res);
      return null;
    }
  }

  Future<Account?> getAccount() async {
    if (jwt == null || jwt == '') {
      return null;
    }

    var res = await http.get(
        Uri(
          host: 'api.gatego.io',
          scheme: 'https',
          path: 'api/account/me',
        ),
        headers: {
          'Accept': '*/*',
          'Authorization': 'Bearer ' + jwt!,
        });

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      acc = Account.fromJson(json);
      return Account.fromJson(json);
    } else {
      print(res.body);
      return null;
    }
  }

  Future<bool> login(String usr, String pw) async {
    if (await getJWT(usr, pw) != null) {
      if (await getAccount() != null) {
        notifyListeners();
        refTimer = Timer.periodic(const Duration(seconds: 120), (timer) {
          print('Refreshing');
          refreshJWT(jwt!);
        });
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void logout() {
    acc = null;
    jwt = null;
    if (refTimer != null) {
      refTimer!.cancel();
      refTimer = null;
    }
    notifyListeners();
  }

  bool isLoggedIn() {
    if (acc == null) {
      return false;
    } else {
      return true;
    }
  }
}

final accountProvider =
    ChangeNotifierProvider.autoDispose<AccountProvider>((ref) {
  return AccountProvider();
});
