import 'package:gatego_unified_app/models/account.dart';
import 'package:gatego_unified_app/models/roles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider.autoDispose<Account>((ref) {
  return Account(isAuth: false);
});
