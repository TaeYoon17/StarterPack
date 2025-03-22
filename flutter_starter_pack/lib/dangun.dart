import 'package:flutter/material.dart';

class Dangun extends StatelessWidget {
  const Dangun({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading:
              // Text("광진구 천호동"),
              IconButton(onPressed: (){},icon: Icon(Icons.arrow_downward))
        ),
        body: Container(
          height: 150,
          color: Colors.green,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              Image.asset("assets/Alamofire.png", width: 66),
              Expanded(
                child:  Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text("캐논 DSLR 100D ( 단렌즈, 충전기 16기가asdfasdfasdfSD 포함",
                      softWrap: true,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text("성동구 행당동"),
                        Text("-"),
                        Text("끌올 10분 전")
                      ],
                    ),
                    Text("210,000원"),
                    Expanded(child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                      Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              // Expanded(child: Container()),
                              Text("안녕하세요"),
                              Icon(Icons.heart_broken)
                          ]),
                      ),
                    ]))
                  ],
                                ),
                ),
              )
            ],
          ),
          
        ),
      )
    );
  }
}
