import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String selectedItemKey;
  final Map<String, Widget> menuItems;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;
  final Function onItemPressed;

  const Menu({
    required this.selectedItemKey,
    required this.menuItems,
    this.leading,
    this.trailing,
    this.expanded = false,
    required this.onItemPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          leading ?? const SizedBox(),
          Expanded(
            child: Column(
              children: [
                ...menuItems.entries.map((item) {
                  bool _itemSelcted = item.key == selectedItemKey;
                  return IconButton(
                    onPressed: () {
                      onItemPressed(item.key);
                    },
                    icon: item.value,
                    color: _itemSelcted
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).iconTheme.color,
                  );
                }).toList(),
              ],
            ),
          ),
          trailing ?? const SizedBox(),
        ],
      );
    } else {
      return Column(
        children: [
          ...menuItems.entries.map((item) {
            return item.value;
          }).toList()
        ],
      );
    }
  }
}
