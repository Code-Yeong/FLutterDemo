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
  int pageNum;
  double totalPosition = 0;

  @override
  void initState() {
    super.initState();
    pageNum = 0;
    _pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView.builder(
      itemBuilder: (context, index) => widget.itemBuilder(context, index),
      physics: AlwaysScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: widget.itemCount,
      autoScrollPage: true,
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
