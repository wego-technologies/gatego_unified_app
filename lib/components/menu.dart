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
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        margin:
                            EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5000),
                          onTap: () {
                            onItemPressed(item.key);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            //margin: EdgeInsets.all(10),
                            width: 170,
                            decoration: BoxDecoration(
                              color: _itemSelcted
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5000),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeroIcon(
                                  item.value,
                                  size: 30,
                                  color: _itemSelcted
                                      ? Theme.of(context).canvasColor
                                      : Theme.of(context).iconTheme.color,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item.key,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: _itemSelcted
                                        ? Colors.white
                                        : Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
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
