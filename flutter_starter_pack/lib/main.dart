import 'package:flutter/material.dart';
import 'dangun.dart';
void main() {
  runApp(const Dangun());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body:
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 150, height: 50,
                // margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Text('dddd'),
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.black)
                ),
              ),
            )

        ,
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star)
            ],
          ),
        )
        ),
      )

        // Image.asset("assets/Alamofire.png")

      // Icon(Icons.star)
    );
  }
}


class Lecture4AppBar extends StatelessWidget {
  const Lecture4AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(leading: Icon(Icons.star), title: Text("내 앱이다"), actions: [Icon(Icons.star)],),
        body: SizedBox(
          child: ElevatedButton(
            child: Text('글자'),
            onPressed: () {},
            style: ButtonStyle()
          )
          // Text("안녕하세요",
          //   style: TextStyle(fontWeight: FontWeight.w700),
          // ),
        ),
      )
    );
  }
}
