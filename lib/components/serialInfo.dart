import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SerialInfo extends ConsumerWidget {
  const SerialInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var serialExternal = watch(serialProvider).state;
    SerialPort? serialSelected;
    if (serialExternal != null) {
      serialSelected = SerialPort(serialExternal);
    }

    return Column(
      children: [
        Row(
          children: [
            HeroIcon(
              HeroIcons.chip,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(serialSelected?.vendorId.toString() ?? "None")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            HeroIcon(
              HeroIcons.lightningBolt,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(serialExternal ?? "None")
          ],
        ),
      ],
    );
  }
}
