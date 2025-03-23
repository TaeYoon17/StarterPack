import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class MyFlexible extends StatelessWidget {
  const MyFlexible({super.key});
  static var flexibleChildren = [
    Flexible(child: Container(color: Colors.blue), flex: 3),
    Flexible(child: Container(color: Colors.green), flex: 7),
    Flexible(child: Container(color: Colors.red), flex: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Row(
          children: [
            Expanded(child: Container(color: Colors.blue,)),
            Container(width: 100, color: Colors.green,)
          ],
        ),
      ),
    );
  }
}
