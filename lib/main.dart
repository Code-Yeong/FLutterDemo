import 'package:flutter/material.dart';
import 'package:flutter_demo/cache/cache_manager_page.dart';
import 'package:flutter_demo/cover_filter/cover_filter.dart';
import 'package:flutter_demo/cross_fade/cross_fade_page.dart';
import 'package:flutter_demo/directionality/directionality_page.dart';
import 'package:flutter_demo/gesture_dector2/gesture_detector.dart';
import 'package:flutter_demo/gesture_detector/gesture_detector.dart';
import 'package:flutter_demo/hearo_animation/hero_main_page.dart';
import 'package:flutter_demo/life_cycle/lifecycle_of_state.dart';
import 'package:flutter_demo/method_channel/method_channel_page.dart';
import 'package:flutter_demo/random_position_widget/random_position_page.dart';
import 'package:flutter_demo/webview/webview_page.dart';

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
              onPressed: () {
//                onItemClicked(TEAnimChangeRoleWidget());
              },
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
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new CoverFilter());
              },
              child: Text("渐变遮罩"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new DirectionalityDemo());
              },
              child: Text("Directionality"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new HeroMainPage());
              },
              child: Text("Hero动画"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new CrossFadeAnimation());
              },
              child: Text("交叉动画"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new MethodChannelPage());
              },
              child: Text("Method channel(only for Android)"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new CacheManagerPage());
              },
              child: Text("缓存管理"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new GestureDetectorPage());
              },
              child: Text("按钮事件"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                onItemClicked(new WebViewPage());
              },
              child: Text("Webview"),
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
