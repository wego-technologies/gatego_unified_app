import 'dart:async';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/components/serialInfo.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SerialCard extends ConsumerStatefulWidget {
  final String title;
  const SerialCard(this.title, {Key? key}) : super(key: key);

  @override
  _SerialCardState createState() => _SerialCardState();
}

class _SerialCardState extends ConsumerState<SerialCard> {
  List<String> availablePorts = [];

  SerialPort? serialSelected;
  Timer? timer;
  bool manualDisconnect = false;

  @override
  void initState() {
    super.initState();
    if (timer == null || !(timer?.isActive ?? true)) {
      timer = Timer.periodic(const Duration(seconds: 1), ((_) {
        checkSerial();
      }));
    }
    initPorts();
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts
        .where((element) => SerialPort(element).vendorId == 6790)
        .toList());
  }

  void checkSerial() {
    final serial = ref.read(serialProvider.state).state;
    final availablePortsNew = SerialPort.availablePorts
        .where((element) => SerialPort(element).vendorId == 6790)
        .toList();

    if (!listEquals(availablePortsNew, availablePorts)) {
      setState(() {
        availablePorts = availablePortsNew;
      });
    }
    final res = availablePorts.contains(serial);
    if (!res && serial != null) {
      serialSelected = null;
      ref.watch(serialProvider.state).state = null;
      manualDisconnect = false;
    }
    if (availablePorts.length == 1 && serial == null && !manualDisconnect) {
      serialSelected = SerialPort(availablePorts.first);
      ref.watch(serialProvider.state).state = availablePorts.first;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer == null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var serialExternal = ref.watch(serialProvider.state).state;
        var sizedBox = const SizedBox(
          width: 50,
        );
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          //constraints: BoxConstraints(maxHeight: 150),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).cardColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: serialExternal == null
                            ? Colors.transparent
                            : const Color(0xff00B633),
                        boxShadow: serialExternal != null
                            ? [
                                const BoxShadow(
                                  color: Color(0xff00B633),
                                  blurRadius: 10,
                                  spreadRadius: 1.5,
                                ),
                              ]
                            : null),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    width: 80,
                    height: 80,
                    child: Icon(
                      serialExternal == null
                          ? FluentSystemIcons.ic_fluent_search_square_regular
                          : FluentSystemIcons.ic_fluent_checkmark_regular,
                      size: 60,
                      color: serialExternal == null
                          ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
                          : Colors.white,
                    ),
                  ),
                  sizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //width: 450,
                        child: Text(
                          serialExternal == null
                              ? 'No Port Selected'
                              : 'Connected to Device',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      serialExternal == null
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                availablePorts.isNotEmpty
                                    ? DropdownButton<String>(
                                        onChanged: (value) {
                                          ref
                                              .watch(serialProvider.state)
                                              .state = value;
                                          serialSelected = SerialPort(value!);
                                          manualDisconnect = false;
                                        },
                                        value: serialExternal,
                                        borderRadius: BorderRadius.circular(10),
                                        underline: const SizedBox(),
                                        hint: const Text('Select a port'),
                                        items: [
                                          ...availablePorts.map((e) {
                                            final port = SerialPort(e);
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                  port.description.toString()),
                                            );
                                          }).toList()
                                        ],
                                      )
                                    : const Text(
                                        'No Devices Detected',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: initPorts,
                                  icon: const Icon(FluentSystemIcons
                                      .ic_fluent_arrow_sync_regular),
                                  color: Theme.of(context).primaryColor,
                                  splashRadius: 20,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  'Ready to ${widget.title}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Tooltip(
                                  message: 'Disconnect',
                                  child: IconButton(
                                    onPressed: () {
                                      initPorts();
                                      serialSelected = null;
                                      ref.watch(serialProvider.state).state =
                                          null;
                                      manualDisconnect = true;
                                    },
                                    splashRadius: 20,
                                    icon: const Icon(
                                      Icons.usb_off_rounded,
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SerialInfo(),
              )
            ],
          ),
        );
      },
    );
  }
}
