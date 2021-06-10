import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Menu extends StatelessWidget {
  final String selectedItemKey;
  final Map<String, HeroIcons> menuItems;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          leading ?? const SizedBox(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: !expanded
                  ? menuItems.entries.map((item) {
                      bool _itemSelcted = item.key == selectedItemKey;
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: IconButton(
                          onPressed: () {
                            onItemPressed(item.key);
                          },
                          icon: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _itemSelcted
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: HeroIcon(
                              item.value,
                              size: 30,
                              color: _itemSelcted
                                  ? Theme.of(context).canvasColor
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                          iconSize: 50,
                          splashRadius: 30,
                        ),
                      );
                    }).toList()
                  : menuItems.entries.map((item) {
                      bool _itemSelcted = item.key == selectedItemKey;
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 11),
                        constraints: BoxConstraints(minWidth: 170),
                        child: TextButton.icon(
                          onPressed: () {
                            onItemPressed(item.key);
                          },
                          icon: HeroIcon(
                            item.value,
                            size: 30,
                            color: _itemSelcted
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).iconTheme.color,
                          ),
                          label: Text(
                            item.key,
                            style: TextStyle(
                              color: _itemSelcted
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft,
                            padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 25,
                              ),
                            ),
                          ),
                          //iconSize: 30,
                          //splashRadius: 30,
                          //color: _itemSelcted
                          //? Theme.of(context).primaryColor
                          //: Theme.of(context).iconTheme.color,
                        ),
                      );
                    }).toList(),
            ),
          ),
          trailing ?? SizedBox(),
        ],
      ),
    );
  }
}
