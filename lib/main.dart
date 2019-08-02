import 'package:flutter/material.dart';
import 'package:flutter_demo/AnimatedList/animated_list_page.dart';
import 'package:flutter_demo/banner/banners.dart';
import 'package:flutter_demo/cache/cache_manager_page.dart';
import 'package:flutter_demo/change_role_widget/anim_change_role.dart';
import 'package:flutter_demo/cover_filter/cover_filter.dart';
import 'package:flutter_demo/cross_fade/cross_fade_page.dart';
import 'package:flutter_demo/directionality/directionality_page.dart';
import 'package:flutter_demo/gesture_dector2/gesture_detector.dart';
import 'package:flutter_demo/gesture_detector/gesture_detector.dart';
import 'package:flutter_demo/hearo_animation/SizeAnimation.dart';
import 'package:flutter_demo/hearo_animation/hero_main_page.dart';
import 'package:flutter_demo/life_cycle/lifecycle_of_state.dart';
import 'package:flutter_demo/method_channel/method_channel_page.dart';
import 'package:flutter_demo/random_position_widget/random_position_page.dart';
import 'package:flutter_demo/shader_mask/shader_mask_page.dart';
import 'package:flutter_demo/slider/slider_page.dart';
import 'package:flutter_demo/split_sentence/main_page.dart';
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
          Container(
            child: _ChoiceEntry(text: '交换角色动画', route: TEAnimChangeRoleWidget()),
          ),
          Container(
            child: _ChoiceEntry(text: 'State生命周期', route: TELifeCycleOfState()),
          ),
          Container(
            child: _ChoiceEntry(text: '自由位置组件', route: RandomPositionWidget()),
          ),
          Container(
            child: _ChoiceEntry(text: '事件穿透', route: GestureDetectorDemo()),
          ),
          Container(
            child: _ChoiceEntry(text: '渐变遮罩', route: CoverFilter()),
          ),
          Container(
            child: _ChoiceEntry(text: 'Directionality', route: DirectionalityDemo()),
          ),
          Container(
            child: _ChoiceEntry(text: 'Hero动画', route: HeroMainPage()),
          ),
          Container(
            child: _ChoiceEntry(text: '交叉动画', route: CrossFadeAnimation()),
          ),
          Container(
            child: _ChoiceEntry(text: '尺寸变化动画', route: SizeAnimationPage()),
          ),
          Container(
            child: _ChoiceEntry(text: 'Method channel(only for Android)', route: MethodChannelPage()),
          ),
          Container(
            child: _ChoiceEntry(text: '缓存管理', route: CacheManagerPage()),
          ),
          Container(
            child: _ChoiceEntry(text: '按钮事件', route: GestureDetectorPage()),
          ),
          Container(
            child: _ChoiceEntry(text: 'Webview', route: WebViewPage()),
          ),
          Container(
            child: _ChoiceEntry(text: 'Banner', route: BannerPage(title: 'Banner')),
          ),
          Container(
            child: _ChoiceEntry(text: 'ShaderMask', route: ShaderMaskPage(title: 'ShaderMask')),
          ),
          Container(
            child: _ChoiceEntry(text: 'Slider(Flutter v1.7+)', route: SliderPage()),
          ),
          Container(
            child: _ChoiceEntry(text: 'AnimatedList', route: AnimatedListPage()),
          ),
          Container(
            child: _ChoiceEntry(text: '句子分割', route: SplitSentencePage()),
          ),
        ],
      ),
    );
  }
}

class _ChoiceEntry extends StatelessWidget {
  final Widget route;
  final String text;

  _ChoiceEntry({this.text, this.route});

  void onItemClicked(BuildContext context, Widget route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return route;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClicked(context, route);
      },
      child: Container(
        width: double.infinity,
        height: 80.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        color: Colors.red.withOpacity(0.1),
        child: Text('$text'),
      ),
    );
  }
}
