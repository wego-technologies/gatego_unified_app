import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCard extends ConsumerWidget {
  final bool expanded;

  const UserCard({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var acc = watch(accountProvider).acc;
    if (expanded) {
      return Container(
        padding: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 0,
                color: Theme.of(context).shadowColor.withAlpha(50),
                offset: const Offset(0, 0),
              )
            ]),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: acc == null
              ? () {
                  Beamer.of(context).beamToNamed('/login');
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: HeroIcon(
                        HeroIcons.user,
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
                    child: HeroIcon(
                      HeroIcons.arrowRight,
                      size: 20,
                    ),
                  ),
                if (acc != null)
                  Material(
                    color: Colors.white,
                    child: Tooltip(
                      message: 'Log Out',
                      child: IconButton(
                        onPressed: () {
                          context.read(accountProvider).logout();
                        },
                        icon: const Icon(
                          Icons.logout_rounded,
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
                  Beamer.of(context).beamToNamed('/login');
                }
              : null,
          borderRadius: BorderRadius.circular(50000),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: HeroIcon(
              HeroIcons.user,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
