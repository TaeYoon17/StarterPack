import 'package:flutter/material.dart';
/// StatelessWidget은 내부 값의 변화에 즉각 렌더링하지 못한다.
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home)),
    BottomNavigationBarItem(icon: Icon(Icons.search)),
    BottomNavigationBarItem(icon: Icon(Icons.add)),
    BottomNavigationBarItem(icon: Icon(Icons.healing)),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle))
  ];

  int _selectedIndex = 0;

  List<Widget> _screens = <Widget> [
    Container(color: Colors.amberAccent),
    Container(color: Colors.redAccent),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.purpleAccent),
  ]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Well Made"),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int value) {
    setState(() {
      this._selectedIndex = value;
    });
  }
}

/// IndexedStack
/// 화면을 그대로 다 그려 놓고 뒤로 보내는 방법 -> 리렌더링을 줄인다.