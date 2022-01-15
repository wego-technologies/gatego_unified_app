import 'package:beamer/beamer.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/pages/login.dart';
import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCard extends ConsumerWidget {
  final bool expanded;

  const UserCard({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var acc = ref.watch(accountProvider).acc;
    if (expanded) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).cardColor,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: acc == null
              ? () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          //insetPadding: EdgeInsets.all(10),
                          child: LoginPage(),
                        );
                      });
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        acc == null
                            ? FluentSystemIcons
                                .ic_fluent_person_accounts_regular
                            : FluentSystemIcons.ic_fluent_person_regular,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          acc == null ? 'Login' : 'Welcome!',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        if (acc != null)
                          Text(
                            acc.name,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                if (acc == null)
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      FluentSystemIcons.ic_fluent_arrow_right_regular,
                      size: 20,
                    ),
                  ),
                if (acc != null)
                  Material(
                    color: Colors.transparent,
                    child: Tooltip(
                      message: 'Log Out',
                      child: IconButton(
                        onPressed: () {
                          ref.read(accountProvider).logout();
                        },
                        icon: const Icon(
                          FluentSystemIcons.ic_fluent_export_filled,
                        ),
                        splashRadius: 20,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }
    return Tooltip(
      message: acc == null ? 'Login' : acc.name,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: acc == null
              ? () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          //insetPadding: EdgeInsets.all(10),
                          child: LoginPage(),
                        );
                      });
                }
              : null,
          borderRadius: BorderRadius.circular(50000),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              acc == null
                  ? FluentSystemIcons.ic_fluent_person_accounts_regular
                  : FluentSystemIcons.ic_fluent_person_regular,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
