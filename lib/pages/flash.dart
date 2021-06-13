import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gatego_unified_app/components/SerialSelect.dart';
import 'package:gatego_unified_app/components/serialInfo.dart';

class FlashPage extends StatelessWidget {
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
                  width: MediaQuery.of(context).size.width - 232,
                  child: Row(
                    children: [
                      Flexible(
                        child: SerialCard(),
                        flex: 5,
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SerialInfo(),
                      ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
