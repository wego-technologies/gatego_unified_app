import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/pages/login.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCard extends ConsumerWidget {
  final bool expanded;

  UserCard({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
          onTap: () {
            Beamer.of(context).beamToNamed("/login");
          },
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
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: HeroIcon(
                    HeroIcons.arrowRight,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50000),
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: HeroIcon(
            HeroIcons.user,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
