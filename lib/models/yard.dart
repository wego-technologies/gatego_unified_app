import 'package:flutter/foundation.dart';

class YardCarrier with ChangeNotifier {
  int carrierCapacity;
  int? carrierId;
  int id;

  YardCarrier({
    required this.carrierCapacity,
    this.carrierId,
    required this.id,
  });
}

class Yard with ChangeNotifier {
  DateTime? createdAt;
  String name;
  int id;
  DateTime? lastModifiedAt;
  bool active;
  String createdBy;
  String? lastmodifiedBy;
  int maxCapacity;
  int organizationId;

  Yard({
    this.createdAt,
    required this.active,
    required this.createdBy,
    this.lastModifiedAt,
    this.lastmodifiedBy,
    required this.maxCapacity,
    required this.name,
    required this.organizationId,
    required this.id,
  });
}
