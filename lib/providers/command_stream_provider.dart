import 'package:hooks_riverpod/hooks_riverpod.dart';

final commandFlashProvider = StateProvider<List<String>>((ref) {
  return [];
});

final commandResetProvider = StateProvider<List<String>>((ref) {
  return [];
});

final inProgProvider = StateProvider<bool>((ref) {
  return false;
});
