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
    var jwt = watch(jwtProvider).state;
    var acc = watch(accountProvider).state;
    if (jwt != "" && acc == null) {
      getAccount(watch).then((value) {
        if (value != null) {
          watch(accountProvider).state = value;
        }
      });
    }
    if (expanded) {
      return Container(
        padding: EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 0,
                color: Theme.of(context).shadowColor.withAlpha(50),
                offset: Offset(0, 0),
              )
            ]),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: acc == null
              ? () {
                  Beamer.of(context).beamToNamed("/login");
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
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          acc == null ? "Login" : "Welcome!",
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: HeroIcon(
                      HeroIcons.arrowRight,
                      size: 20,
                    ),
                  ),
                if (acc != null)
                  Material(
                    child: Tooltip(
                      message: "Log Out",
                      child: IconButton(
                        onPressed: () {
                          watch(jwtProvider).state = "";
                          watch(accountProvider).state = null;
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                        ),
                        splashRadius: 20,
                      ),
                    ),
                    color: Colors.white,
                  )
              ],
            ),
          ),
        ),
      );
    }
    return Tooltip(
      message: acc == null ? "Login" : acc.name,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: acc == null
              ? () {
                  Beamer.of(context).beamToNamed("/login");
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
