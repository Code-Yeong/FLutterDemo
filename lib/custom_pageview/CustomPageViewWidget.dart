import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter_demo/custom_pageview/MyCustomPageViewWidget.dart';

class CustomPageViewWidget extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  CustomPageViewWidget({
    this.itemCount,
    this.itemBuilder,
  });

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageViewWidget> {
  PageController _pageController;
  Duration _duration;
  double _startX;
  double _endX;
  int pageNum;
  double totalPosition = 0;

  @override
  void initState() {
    super.initState();
    pageNum = 0;
    _duration = Duration(milliseconds: 500);
    _pageController = new PageController();
//    _pageController.addListener(() {
//      ScrollDirection _scrollDirection = _pageController.position.userScrollDirection;
//      if (_scrollDirection == ScrollDirection.forward) {
//        // 往左
////        _pageController.previousPage(duration: _duration, curve: Curves.ease);
//        print("forword");
//      } else if (_scrollDirection == ScrollDirection.reverse) {
////        _pageController.nextPage(duration: _duration, curve: Curves.ease);
//        // 往右
//        print("reverse");
//      } else {
////        print("idle");
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView.builder(
      itemBuilder: (context, index) => widget.itemBuilder(context, index),
//        physics: NeverScrollableScrollPhysics(),
      physics: AlwaysScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: widget.itemCount,
      onPageBeginChange: (index){
        print('page begin change: $index');
      },
      onPageChanged: (index){
        print("page: $index");
      },
    );
  }

  @override
  void dispose() {
    if (_pageController != null) {
      _pageController.dispose();
      _pageController = null;
    }
    super.dispose();
  }
}
