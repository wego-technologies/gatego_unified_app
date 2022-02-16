import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

enum ProgressCardState {
  inProgress,
  pending,
  done,
  fail,
}

class ProgressCard extends StatefulWidget {
  final String text;
  final Widget icon;
  final ProgressCardState state;
  final bool showTrailing;

  const ProgressCard({
    required this.text,
    required this.state,
    required this.icon,
    this.showTrailing = true,
    Key? key,
  }) : super(key: key);

  @override
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  late BoxDecoration boxDecor;
  @override
  Widget build(BuildContext context) {
    Widget? trailing;

    if (widget.state == ProgressCardState.inProgress) {
      setState(() {
        boxDecor = BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: widget.state == ProgressCardState.inProgress
              ? [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Theme.of(context).shadowColor.withAlpha(50),
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
        );
      });
    } else {
      boxDecor = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? const Color.fromARGB(255, 240, 240, 240)
            : const Color.fromARGB(255, 46, 46, 46),
        borderRadius: BorderRadius.circular(5),
      );
    }

    if (widget.showTrailing) {
      switch (widget.state) {
        case ProgressCardState.done:
          {
            trailing = Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(100000),
              ),
              child: const Icon(
                FluentSystemIcons.ic_fluent_checkmark_circle_filled,
                size: 15,
                color: Colors.green,
              ),
            );
          }
          break;
        case ProgressCardState.inProgress:
          {
            trailing = Container(
              width: 15,
              height: 15,
              //margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(100000),
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          }
          break;
        case ProgressCardState.pending:
          {
            trailing = Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(100000),
              ),
              child: Icon(
                FluentSystemIcons.ic_fluent_clock_filled,
                size: 15,
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 240, 240, 240)
                    : const Color.fromARGB(255, 78, 78, 78),
              ),
            );
          }
          break;
        case ProgressCardState.fail:
          {
            trailing = Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(100000),
              ),
              child: Icon(
                FluentSystemIcons.ic_fluent_dismiss_circle_filled,
                size: 15,
                color: Theme.of(context).errorColor,
              ),
            );
          }
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 65,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: boxDecor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: double.infinity,
                width: 35,
                child: Stack(
                  children: [
                    Center(child: widget.icon),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: trailing ?? const SizedBox(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 240, 240, 240)
                      : const Color.fromARGB(255, 78, 78, 78),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
