import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_indicator/loading_indicator.dart';

enum ProgressCardState {
  inProgress,
  pending,
  done,
}

class ProgressCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Widget? trailing;

    if (showTrailing) {
      switch (state) {
        case ProgressCardState.done:
          {
            trailing = HeroIcon(
              HeroIcons.checkCircle,
              solid: true,
              size: 20,
              color: Colors.green,
            );
          }
          break;
        case ProgressCardState.inProgress:
          {
            trailing = Container(
              width: 20,
              //margin: EdgeInsets.only(right: 15),
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
              ),
            );
          }
          break;
        case ProgressCardState.pending:
          {
            trailing = HeroIcon(
              HeroIcons.clock,
              size: 20,
              color: state != ProgressCardState.inProgress
                  ? Theme.of(context).disabledColor.withAlpha(150)
                  : Color(0xff353535),
            );
          }
          break;
      }
    }

    return Container(
      height: 65,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: state != ProgressCardState.inProgress
            ? Colors.transparent
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: state == ProgressCardState.inProgress
            ? [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: Theme.of(context).shadowColor.withAlpha(50),
                  offset: Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: state != ProgressCardState.inProgress
                      ? Theme.of(context).disabledColor.withAlpha(150)
                      : Color(0xff353535),
                ),
              ),
            ],
          ),
          trailing ?? SizedBox(),
        ],
      ),
    );
  }
}
