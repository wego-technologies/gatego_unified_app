import 'package:hooks_riverpod/hooks_riverpod.dart';

final commandProvider = StateProvider.autoDispose<List<String>>((ref) {
  return [];
});
