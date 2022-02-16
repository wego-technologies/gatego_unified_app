import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/providers/serial_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SerialInfo extends ConsumerWidget {
  const SerialInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var serialExternal = ref.watch(serialProvider.state).state;
    SerialPort? serialSelected;
    if (serialExternal != null) {
      serialSelected = SerialPort(serialExternal);
    }

    return Row(
      children: [
        Column(
          children: const [
            Icon(
              FluentSystemIcons.ic_fluent_developer_board_regular,
              size: 30,
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              FluentSystemIcons.ic_fluent_usb_stick_regular,
              size: 30,
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(serialSelected?.vendorId.toString() ?? 'None'),
            const SizedBox(
              height: 20,
            ),
            Text(serialExternal ?? 'None')
          ],
        ),
      ],
    );
  }
}
