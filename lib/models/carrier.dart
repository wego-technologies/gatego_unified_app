import 'package:flutter/foundation.dart';

import 'yard.dart';

class Carrier with ChangeNotifier {
  DateTime createdAt;
  String createdBy;
  String fleetId;
  int id;
  DateTime lastModifiedAt;
  String lastModifiedBy;
  String name;
  String scac;
  List<YardCarrier> yards;

  Carrier({
    @required this.createdAt,
    @required this.createdBy,
    @required this.fleetId,
    @required this.lastModifiedAt,
    @required this.lastModifiedBy,
    @required this.name,
    @required this.scac,
    @required this.yards,
    @required this.id,
  });
}
