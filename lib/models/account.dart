import 'dart:convert';

import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class Account {
  late int id;
  late String username;
  late bool active;
  late String role;
  String? email;
  late String name;
  String? phoneNumber;
  String? languageCode;
  int? yardId;
  int? carrierId;
  Organization? organization;

  Account({
    required this.id,
    required this.username,
    required this.active,
    required this.role,
    this.email,
    required this.name,
    this.phoneNumber,
    this.languageCode,
    this.yardId,
    this.carrierId,
    this.organization,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    active = json['active'];
    role = json['role'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    languageCode = json['language_code'];
    yardId = json['yard_id'];
    carrierId = json['carrier_id'];
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['active'] = active;
    data['role'] = role;
    data['email'] = email;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['language_code'] = languageCode;
    data['yard_id'] = yardId;
    data['carrier_id'] = carrierId;
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    return data;
  }
}

class Organization {
  late int id;
  late String name;

  Organization({
    required this.id,
    required this.name,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
