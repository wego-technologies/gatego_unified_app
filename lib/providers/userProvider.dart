import 'package:gatego_unified_app/models/account.dart';
import 'package:gatego_unified_app/models/roles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = Provider<Account>((ref) {
  return Account(active: true, role: Role.ADMIN, name: "name", id: 15864);
});
