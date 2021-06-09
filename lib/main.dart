import 'package:flutter/material.dart';

void main() {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gatego Autonomous+ Tools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0x00ADE2FF),
      ),
      home: FlashDevice(),
    );
  }
}

class FlashDevice extends StatelessWidget {
  const FlashDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello"),
    );
  }
}
