import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FluentSystemIcons.ic_fluent_flash_on_filled,
            color: Colors.yellow.shade800,
            size: 100,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Coming Soon',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
