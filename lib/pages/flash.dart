import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class FlashPage extends StatefulWidget {
  const FlashPage({Key? key}) : super(key: key);

  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  var availablePorts = [];

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
    return Expanded(
      child: Scrollbar(
        child: ListView(
          children: [
            TextButton(onPressed: initPorts, child: Text("Refresh")),
            for (final address in availablePorts)
              Builder(builder: (context) {
                final port = SerialPort(address);
                return ExpansionTile(
                  title: Text(address),
                  children: [
                    CardListTile('Description', port.description),
                    CardListTile('Transport', port.transport.toString()),
                    CardListTile('USB Bus', port.busNumber?.toString()),
                    CardListTile('USB Device', port.deviceNumber?.toString()),
                    CardListTile('Vendor ID', port.vendorId?.toString()),
                    CardListTile('Product ID', port.productId?.toString()),
                    CardListTile('Manufacturer', port.manufacturer),
                    CardListTile('Product Name', port.productName),
                    CardListTile('Serial Number', port.serialNumber),
                    CardListTile('MAC Address', port.macAddress),
                  ],
                );
              }),
          ],
        ),
      ),
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
