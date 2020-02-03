import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/AnimatedList/animated_list_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

GlobalKey key = new GlobalKey(debugLabel: 'TestWidgetA');
class _MainPageState extends State<MainPage> {
  bool isShowingA = true;

  TestWidgetA testWidgetA;
  TestWidgetB testWidgetB;

  @override
  void initState() {
    super.initState();
    print('init Main pate');

  }

  test(){}

  @override
  Widget build(BuildContext context) {
//    print(testWidgetA.state);
//    print('A : ${testWidgetA.hashCode}');
//    print('B : ${testWidgetB.hashCode}');
//    testWidgetA = TestWidgetA(key: key);
//    testWidgetB = TestWidgetB();
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        actions: <Widget>[
          RaisedButton(
            child: Text('${isShowingA ? "showB" : "showA"}'),
            onPressed: () {
//              setState(() {
//                isShowingA = !isShowingA;
//              });
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return AnimatedListPage();
//                return BannerPage();
              }));
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isShowingA ? TestWidgetA(key: key) : TestWidgetB(),
//            Offstage(
//              offstage: !isShowingA,
//              child: testWidgetA,
//            ),
//            Offstage(
//              offstage: isShowingA,
//              child: testWidgetB,
//            ),
          ListView(),
          ],
        ),
      ),
    );
  }
}

class TestWidgetA extends StatefulWidget {
  final GlobalKey key;
  State state;

  void hello() {
    print('helloff');
  }

  TestWidgetA({this.key}) : super(key: key);

  @override
  _TestWidgetAState createState() {
    print('--------');
    state = _TestWidgetAState();
    return state;
  }
}

class _TestWidgetAState extends State<StatefulWidget> {
  String text;
  Timer timer;
  int count = 0;
  @override
  void initState() {
    super.initState();
//    timer = new Timer.periodic(Duration(milliseconds: 1000), (timer) {
//      setState(() {
//        text = '$text ${count++}';
//      });
//    });
    text = 'this is A';
    print('init widget A');
  }

  @override
  Widget build(BuildContext context) {

    var wwww = widget;
    if(wwww is TestWidgetA){
      wwww.hello();
    }
    print('build widget A');
    return Container(
      child: Text('$text'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose widget A');
  }
}

class TestWidgetB extends StatefulWidget {
  @override
  _TestWidgetBState createState() => _TestWidgetBState();
}

class _TestWidgetBState extends State<TestWidgetB> {
  String text;

  @override
  void initState() {
    super.initState();
    text = 'this is B';
    print('init widget B');
  }

  @override
  Widget build(BuildContext context) {
    print('build widget B');
    return Container(
      child: Text('$text'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose widget B');
  }
}
