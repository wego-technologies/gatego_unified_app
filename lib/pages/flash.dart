import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:heroicons/heroicons.dart';

class FlashPage extends StatefulWidget {
  const FlashPage({Key? key}) : super(key: key);

  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  List<String> availablePorts = ["COM4"];

  var portSelected;

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
    if (!availablePorts.contains(portSelected)) {
      portSelected = null;
    }
    return Expanded(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  //constraints: BoxConstraints(maxHeight: 150),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: portSelected == null
                                ? Colors.transparent
                                : Color(0xff00B633),
                            boxShadow: portSelected != null
                                ? [
                                    BoxShadow(
                                      color: Color(0xff00B633),
                                      blurRadius: 10,
                                      spreadRadius: 1.5,
                                    ),
                                  ]
                                : null),
                        padding: portSelected == null
                            ? EdgeInsets.zero
                            : EdgeInsets.all(10),
                        width: 100,
                        height: 100,
                        child: HeroIcon(
                          portSelected == null
                              ? HeroIcons.questionMarkCircle
                              : HeroIcons.check,
                          size: 100,
                          color: portSelected == null
                              ? Theme.of(context).iconTheme.color
                              : Colors.white,
                          solid: true,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            portSelected == null
                                ? "No Port Selected"
                                : "Connected to $portSelected",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          portSelected == null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DropdownButton(
                                      onChanged: (value) {
                                        setState(() {
                                          portSelected = value;
                                        });
                                      },
                                      value: portSelected,
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
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: initPorts,
                                      icon: Icon(Icons.refresh_rounded),
                                      color: Theme.of(context).primaryColor,
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
                                            setState(() {
                                              portSelected = null;
                                            });
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
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
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
