import '../models/carrier.dart';
import '../models/organization.dart';
import '../models/roles.dart';
import 'driver.dart';

import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  bool active;
  List<dynamic>? canViewCarrierIds;
  Carrier? carrier;
  DateTime? deletedAt;
  Driver? driver;
  String? email;
  int id;
  String name;
  Organization? organization;
  String? phoneNumber;
  Role role;
  double? yardId;

  Account({
    required this.active,
    required this.role,
    required this.name,
    required this.id,
    this.canViewCarrierIds,
    this.carrier,
    this.deletedAt,
    this.driver,
    this.email,
    this.phoneNumber,
    this.organization,
    this.yardId,
  });
}
