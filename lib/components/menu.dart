import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Menu extends StatelessWidget {
  final String selectedItemKey;
  final Map<String, HeroIcons> menuItems;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;
  final Function onItemPressed;
  final Function onExpandedToggle;

  const Menu({
    required this.selectedItemKey,
    required this.menuItems,
    this.leading,
    this.trailing,
    this.expanded = false,
    required this.onItemPressed,
    required this.onExpandedToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: -2)],
        color: Theme.of(context).canvasColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
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
          Container(
            //constraints: const BoxConstraints(minWidth: double.infinity),
            margin: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(5000),
              onTap: () {
                onExpandedToggle();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                //margin: EdgeInsets.all(10),
                //width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5000),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeroIcon(
                      !expanded
                          ? HeroIcons.chevronRight
                          : HeroIcons.chevronLeft,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    if (expanded)
                      SizedBox(
                        width: 10,
                      ),
                    if (expanded)
                      Text(
                        "Contract Menu",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    if (expanded)
                      SizedBox(
                        width: 5,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}