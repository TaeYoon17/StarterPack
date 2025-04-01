import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class MyFlexible extends StatelessWidget {
  const MyFlexible({super.key});
  static var flexibleChildren = [
    Flexible(flex: 3, child: Container(color: Colors.blue)),
    Flexible(flex: 7, child: Container(color: Colors.green)),
    Flexible(flex: 5, child: Container(color: Colors.red))
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
