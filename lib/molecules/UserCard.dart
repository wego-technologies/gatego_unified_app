import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class UserCard extends StatelessWidget {
  final bool expanded;

  const UserCard({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 10, spreadRadius: -5, offset: Offset(0, 0))
            ]),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
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
      padding: const EdgeInsets.only(bottom: 16),
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
