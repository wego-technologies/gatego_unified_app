import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:heroicons/heroicons.dart';
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

  @override
  void initState() {
    super.initState();
    initPorts();
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts
        .where((element) => SerialPort(element).vendorId == 6790)
        .toList());
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
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 0,
                color: Theme.of(context).shadowColor.withAlpha(20),
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Row(
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
                padding: serialExternal == null
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(10),
                width: 100,
                height: 100,
                child: HeroIcon(
                  serialExternal == null
                      ? HeroIcons.cubeTransparent
                      : HeroIcons.check,
                  size: 100,
                  color: serialExternal == null
                      ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
                      : Colors.white,
                  solid: false,
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
                                      ref.watch(serialProvider.state).state =
                                          value;
                                      serialSelected = SerialPort(value!);
                                    },
                                    value: serialExternal,
                                    borderRadius: BorderRadius.circular(10),
                                    underline: SizedBox(),
                                    hint: Text("Select a port"),
                                    items: [
                                      ...availablePorts.map((e) {
                                        final port = SerialPort(e);
                                        return DropdownMenuItem(
                                          value: e,
                                          child:
                                              Text(port.description.toString()),
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
                              icon: const Icon(Icons.refresh_rounded),
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
                                  ref.watch(serialProvider.state).state = null;
                                },
                                splashRadius: 20,
                                icon: const Icon(
                                  Icons.usb_off,
                                  color: Color(0xff353535),
                                ),
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
