import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String selectedItemKey;
  final Map<String, Widget> menuItems;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;

  const Menu({
    required this.selectedItemKey,
    required this.menuItems,
    this.leading,
    this.trailing,
    this.expanded = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return Row(
        children: [
          ...menuItems.entries.map((item) {
            return item.value;
          }).toList()
        ],
      );
    } else {
      return Container();
    }
  }
}
