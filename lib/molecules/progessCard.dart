import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loading_indicator/loading_indicator.dart';

enum ProgressCardState {
  inProgress,
  pending,
  done,
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
          color: widget.state != ProgressCardState.inProgress
              ? Colors.transparent
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: widget.state == ProgressCardState.inProgress
              ? [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Theme.of(context).shadowColor.withAlpha(50),
                    offset: Offset(0, 0),
                  ),
                ]
              : [],
        );
      });
    } else {
      boxDecor = BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      );
    }

    if (widget.showTrailing) {
      switch (widget.state) {
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
              color: Color(0xff353535),
            );
          }
          break;
      }
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 65,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: boxDecor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.icon,
              SizedBox(
                width: 15,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff353535),
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
