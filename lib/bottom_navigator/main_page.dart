import 'package:flutter/material.dart';

class TestBottomNavigatorPage extends StatefulWidget {
  @override
  _TestBottomNavigatorPageState createState() => _TestBottomNavigatorPageState();
}

class _TestBottomNavigatorPageState extends State<TestBottomNavigatorPage> with TickerProviderStateMixin {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('current page is $currentTabIndex'),
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: TabController(length: 3, initialIndex: 0, vsync: this),
        tabs: <Widget>[
          Container(
            width: double.infinity,
            height: 50.0,
            child: Text('111'),
            color: Colors.red,
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            child: Text('112'),
            color: Colors.red,
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            child: Text('113'),
            color: Colors.red,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
