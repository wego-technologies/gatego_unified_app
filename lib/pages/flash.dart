import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/actions/falsh.dart';
import 'package:gatego_unified_app/molecules/console.dart';
import '../components/SerialSelect.dart';
import '../components/actionCard.dart';
import '../components/serialInfo.dart';
import 'package:heroicons/heroicons.dart';

class FlashPage extends StatelessWidget {
  final bool extended;
  final List<ActionItem> actions;
  final String title;
  final String button;

  const FlashPage(
    this.extended, {
    required this.actions,
    this.title = 'Flash',
    this.button = 'Flashing',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width:
                    MediaQuery.of(context).size.width - (extended ? 282 : 232),
                child: Row(
                  children: [
                    Flexible(
                      flex: 5,
                      child: SerialCard(title),
                    ),
                    const Flexible(
                        child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: SerialInfo(),
                    ))
                  ],
                ),
              ),
            ],
          ),
          ActionCard(
            actions: actions,
            buttonIcon: const HeroIcon(HeroIcons.play),
            buttonText: 'Start $button',
          ),
        ],
      ),
    );
  }
}
