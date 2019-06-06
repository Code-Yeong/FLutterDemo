import 'package:flutter/material.dart';
import 'package:flutter_demo/gesture_detector/gesture_detector.dart';
import 'package:flutter_demo/life_cycle/lifecycle_of_state.dart';
import 'package:flutter_demo/random_position_widget/random_position_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      showSemanticsDebugger: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: null,
              child: Text("交换角色动画"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new TELifeCycleOfState());
              },
              child: Text("State生命周期"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new RandomPositionWidget());
              },
              child: Text("自由位置组件"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new GestureDetectorDemo());
              },
              child: Text("事件穿透"),
            ),
          ),
        ],
      ),
    );
  }

  void onItemClicked(Widget route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return route;
    }));
  }
}
