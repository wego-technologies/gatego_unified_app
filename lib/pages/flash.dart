import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/actions/falsh.dart';
import '../components/SerialSelect.dart';
import '../components/actionCard.dart';
import '../components/serialInfo.dart';
import 'package:heroicons/heroicons.dart';

class FlashPage extends StatelessWidget {
  final bool extended;

  const FlashPage(this.extended);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width -
                      (extended ? 282 : 232),
                  child: Row(
                    children: const [
                      Flexible(
                        flex: 5,
                        child: SerialCard(),
                      ),
                      Flexible(
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
              actions: flashActions,
              buttonIcon: const HeroIcon(HeroIcons.play),
              buttonText: 'Start Flashing',
            ),
          ],
        ),
      ),
    );
  }
}
