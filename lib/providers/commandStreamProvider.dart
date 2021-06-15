import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final commandStreamProvider =
    StateProvider.autoDispose<StreamController<List<String>>>((ref) {
  var controller = StreamController<List<String>>();
  return controller;
});
