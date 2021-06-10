import 'package:flutter/foundation.dart';

class Driver with ChangeNotifier{
  String license;
  String licensePictureId;
  String truckNumber;

  Driver({
    @required this.license,
    @required this.licensePictureId,
    @required this.truckNumber
  });
}
