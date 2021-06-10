import 'package:flutter/foundation.dart';

class Organization with ChangeNotifier {
  int id;
  String name;

  Organization({
    required this.id,
    required this.name,
  });
}
