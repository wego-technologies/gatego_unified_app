import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Menu extends ConsumerWidget {
  final String selectedItemKey;
  final Map<String, IconData> menuItems;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;
  final Function? onItemPressed;
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            leading ?? const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: !expanded
                    ? menuItems.entries.map((item) {
                        var _itemSelcted = item.key == selectedItemKey;
                        return Tooltip(
                          message: onItemPressed != null ? item.key : '',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 11),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: onItemPressed != null
                                  ? () {
                                      onItemPressed!(item.key);
                                    }
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: _itemSelcted
                                      ? Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerStart,
                                  children: [
                                    if (_itemSelcted)
                                      Container(
                                        width: 5,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(
                                        item.value,
                                        size: 30,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    : menuItems.entries.map((item) {
                        var _itemSelcted = item.key == selectedItemKey;
                        return Container(
                          constraints: const BoxConstraints(minWidth: 200),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: onItemPressed != null
                                ? () {
                                    onItemPressed!(item.key);
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 10, top: 10, bottom: 10),
                              //margin: EdgeInsets.all(10),
                              width: 170,
                              decoration: BoxDecoration(
                                color: _itemSelcted
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: _itemSelcted
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(10000),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    item.value,
                                    size: 30,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    item.key,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                  const SizedBox(
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
            trailing ?? const SizedBox(),
            Container(
              //constraints: const BoxConstraints(minWidth: double.infinity),
              margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onExpandedToggle();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  //margin: EdgeInsets.all(10),
                  //width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        !expanded
                            ? FluentSystemIcons.ic_fluent_chevron_right_regular
                            : FluentSystemIcons.ic_fluent_chevron_left_regular,
                        size: 30,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      if (expanded)
                        const SizedBox(
                          width: 10,
                        ),
                      if (expanded)
                        Text(
                          'Minimize Menu',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      if (expanded)
                        const SizedBox(
                          width: 5,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
