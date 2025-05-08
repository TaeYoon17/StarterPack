import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomePage()
    );
  }
}


/// 머터리얼 앱의 생성자 중 주요 프로퍼티
/// 1. home => 본인
/// child -> 자식 위젯
/// routes -> 경로 설정
/// theme -> 테마
/// 2. Scaffold - 머터리얼 디자인에서 기본이 되는 레이아웃 구조
///