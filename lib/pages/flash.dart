import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gatego_unified_app/providers/serialProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlashPage extends StatefulWidget {
  const FlashPage({Key? key}) : super(key: key);

  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  List<String> availablePorts = [];

  SerialPort? serialSelected;

  @override
  void initState() {
    super.initState();
    initPorts();
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        var serialExternal = watch(serialProvider).state;
        if (serialExternal != null &&
            !availablePorts.contains(serialExternal)) {
          serialSelected = null;
          watch(serialProvider).state = null;
        }
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
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            //constraints: BoxConstraints(maxHeight: 150),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withAlpha(20),
                                  offset: Offset(0, 0),
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
                                          : Color(0xff00B633),
                                      boxShadow: serialExternal != null
                                          ? [
                                              BoxShadow(
                                                color: Color(0xff00B633),
                                                blurRadius: 10,
                                                spreadRadius: 1.5,
                                              ),
                                            ]
                                          : null),
                                  padding: serialExternal == null
                                      ? EdgeInsets.zero
                                      : EdgeInsets.all(10),
                                  width: 100,
                                  height: 100,
                                  child: HeroIcon(
                                    serialExternal == null
                                        ? HeroIcons.questionMarkCircle
                                        : HeroIcons.check,
                                    size: 100,
                                    color: serialExternal == null
                                        ? Theme.of(context).iconTheme.color
                                        : Colors.white,
                                    solid: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      //width: 450,
                                      child: Text(
                                        serialExternal == null
                                            ? "No Port Selected"
                                            : "Connected to $serialExternal",
                                        style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    serialExternal == null
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              DropdownButton<String>(
                                                onChanged: (value) {
                                                  watch(serialProvider).state =
                                                      value;
                                                  serialSelected =
                                                      SerialPort(value!);
                                                },
                                                value: serialExternal,
                                                items: [
                                                  ...availablePorts.map((e) {
                                                    final port = SerialPort(e);
                                                    return DropdownMenuItem(
                                                      value: e,
                                                      child: Text(port
                                                          .description
                                                          .toString()),
                                                    );
                                                  }).toList()
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                onPressed: initPorts,
                                                icon:
                                                    Icon(Icons.refresh_rounded),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                splashRadius: 20,
                                              )
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "Ready to Flash",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Tooltip(
                                                message: "Disconnect",
                                                child: IconButton(
                                                    onPressed: () {
                                                      serialSelected = null;
                                                      watch(serialProvider)
                                                          .state = null;
                                                    },
                                                    splashRadius: 20,
                                                    icon: Icon(
                                                      Icons.usb_off,
                                                      color: Color(0xff353535),
                                                    )),
                                              )
                                            ],
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
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
                                  Text(serialSelected?.vendorId.toString() ??
                                      "None")
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
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}
