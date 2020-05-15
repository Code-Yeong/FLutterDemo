// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/custom_pageview/MyCustomPageViewWidget.dart';
import 'package:flutter_demo/utils/render_box_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'photo_view_widget.dart';
import 'transformations_demo_board.dart';
import 'transformations_demo_edit_board_point.dart';

// BEGIN transformationsDemo#1

class TransformationsDemo extends StatefulWidget {
  const TransformationsDemo({Key key}) : super(key: key);

  @override
  _TransformationsDemoState createState() => _TransformationsDemoState();
}

GlobalKey conKey = GlobalKey();
int gestureType;

class _TransformationsDemoState extends State<TransformationsDemo> with SingleTickerProviderStateMixin {
  // 播放时长, 秒
  static const _kAudioDuration = 10;

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: _kAudioDuration));
    _animationController.addListener(() {
      setState(() {
        position = (_animationController.value * _kAudioDuration / avgTime).floor();
        if (position >= _textList.length) {
          position--;
        }
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
    textCount = _textList.length;
    avgTime = _kAudioDuration / textCount;
  }

  int textCount = 0;
  double avgTime = 0.0;
  int position = 0;

  static const List<TextSpan> _textSpanList = [
    TextSpan(text: 'Hello '),
    TextSpan(text: 'friends, '),
    TextSpan(text: 'Kitty '),
    TextSpan(text: 'is '),
    TextSpan(text: 'writing '),
    TextSpan(text: 'code '),
    TextSpan(text: 'in '),
    TextSpan(text: 'his '),
    TextSpan(text: 'room, '),
    TextSpan(text: 'and '),
    TextSpan(text: 'forgot '),
    TextSpan(text: 'to '),
    TextSpan(text: 'eat '),
    TextSpan(text: 'lunch. '),
    TextSpan(text: 'Hello '),
    TextSpan(text: 'friends, '),
    TextSpan(text: 'Kitty '),
    TextSpan(text: 'is '),
    TextSpan(text: 'writing '),
    TextSpan(text: 'code '),
    TextSpan(text: 'in '),
    TextSpan(text: 'his '),
    TextSpan(text: 'room, '),
    TextSpan(text: 'and '),
    TextSpan(text: 'forgot '),
    TextSpan(text: 'to '),
    TextSpan(text: 'eat '),
    TextSpan(text: 'lunch. '),
  ];

  static List<GlobalKey> key = [
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
  ];

  static List<Text> _textList = [
    Text('Hello '),
    Text('friends, '),
    Text('Kitty '),
    Text('is '),
    Text('writing '),
    Text('code '),
    Text('in '),
    Text('his '),
    Text('room, '),
    Text('and '),
    Text('forgot '),
    Text('to '),
    Text('eat '),
    Text('lunch. '),
    Text('Hello '),
    Text('friends, '),
    Text('Kitty '),
    Text('is '),
    Text('writing '),
    Text('code '),
    Text('in '),
    Text('his '),
    Text('room, '),
    Text('and '),
    Text('forgot '),
    Text('to '),
    Text('eat '),
    Text('lunch. '),
  ];

  static List<Text> _textList2 = [
    Text('Hello ', key: key[0], style: TextStyle(color: Colors.red)),
    Text('friends, ', key: key[1], style: TextStyle(color: Colors.red)),
    Text('Kitty ', key: key[2], style: TextStyle(color: Colors.red)),
    Text('is ', key: key[3], style: TextStyle(color: Colors.red)),
    Text('writing ', key: key[4], style: TextStyle(color: Colors.red)),
    Text('code ', key: key[5], style: TextStyle(color: Colors.red)),
    Text('in ', key: key[6], style: TextStyle(color: Colors.red)),
    Text('his ', key: key[7], style: TextStyle(color: Colors.red)),
    Text('room, ', key: key[8], style: TextStyle(color: Colors.red)),
    Text('and ', key: key[9], style: TextStyle(color: Colors.red)),
    Text('forgot ', key: key[10], style: TextStyle(color: Colors.red)),
    Text('to ', key: key[11], style: TextStyle(color: Colors.red)),
    Text('eat ', key: key[12], style: TextStyle(color: Colors.red)),
    Text('lunch. ', key: key[13], style: TextStyle(color: Colors.red)),
    Text('Hello ', key: key[14], style: TextStyle(color: Colors.red)),
    Text('friends, ', key: key[15], style: TextStyle(color: Colors.red)),
    Text('Kitty ', key: key[16], style: TextStyle(color: Colors.red)),
    Text('is ', key: key[17], style: TextStyle(color: Colors.red)),
    Text('writing ', key: key[18], style: TextStyle(color: Colors.red)),
    Text('code ', key: key[19], style: TextStyle(color: Colors.red)),
    Text('in ', key: key[20], style: TextStyle(color: Colors.red)),
    Text('his ', key: key[21], style: TextStyle(color: Colors.red)),
    Text('room, ', key: key[22], style: TextStyle(color: Colors.red)),
    Text('and ', key: key[23], style: TextStyle(color: Colors.red)),
    Text('forgot ', key: key[24], style: TextStyle(color: Colors.red)),
    Text('to ', key: key[25], style: TextStyle(color: Colors.red)),
    Text('eat ', key: key[26], style: TextStyle(color: Colors.red)),
    Text('lunch. ', key: key[27], style: TextStyle(color: Colors.red)),
  ];

  Offset translate = Offset.zero;
  double scaled = 1;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          allowImplicitScrolling: true,
          controller: _pageController,
          itemBuilder: (context, index) {
            return TEPhotoViewWidget(
              onTapUp: (details) {
                print('clicked = ${details.globalPosition}');
              },
//              onScaleUpdate: (details){
//                print(details);
//              },
              onScrollTo: (direction) {
                if (direction == ScrollDirection.forward) {
                  _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else {
                  _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                }
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Wrap(children: _textList.sublist(0, 14)),
                          Container(height: 20.0, width: double.infinity),
                          Wrap(children: _textList.sublist(14, 27)),
                        ],
                      ),
                    ),
                  ),
                  ClipPath(
                      clipBehavior: Clip.antiAlias,
                      clipper: RectClipper(
                        ratio: (_animationController.value * _kAudioDuration - position * avgTime) / avgTime,
                        textContext: key[position].currentContext,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        color: Colors.blue.withOpacity(0.2),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Wrap(children: _textList2.sublist(0, 14)),
                              Container(height: 20.0, width: double.infinity),
                              Wrap(children: _textList2.sublist(14, 27)),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
//              child: Stack(
//                alignment: AlignmentDirectional.center,
//                children: <Widget>[
//                  ClipPath(
//                    clipper: RectClipper(
//                      cxt: context,
//                      ratio: _animation?.value?? 0,
//                      curRect: Rect.fromLTWH(40.0, 120.0, 180.0, 20.0),
//                    ),
//                    child: index % 2 == 0 ? Image.asset('assets/images/grandpa.png') : Image.asset('assets/images/granddaughter.png'),
//                  ),
//                  SvgPicture.asset('assets/svg/report_bg_layer_1.svg'),
//                ],
//              ),
              size: MediaQuery.of(context).size,
            );
          },
          itemCount: 1,
        ),
      ),
      persistentFooterButtons: [resetButton, startPlay],
    );
  }

  IconButton get resetButton {
    return IconButton(
      onPressed: () {
        (conKey.currentState as TEPhotoViewWidgetState).animateResetInitialize();
      },
      tooltip: 'reset',
      color: Theme.of(context).colorScheme.surface,
      icon: const Icon(Icons.replay),
    );
  }

  IconButton get startPlay {
    return IconButton(
      icon: const Icon(Icons.play_arrow),
      tooltip: 'play',
      color: Theme.of(context).colorScheme.surface,
      onPressed: () {
        _animationController.forward();
      },
    );
  }
}

class BoardPainter extends CustomPainter {
  const BoardPainter({
    this.board,
  });

  final Board board;

  @override
  void paint(Canvas canvas, Size size) {
    void drawBoardPoint(BoardPoint boardPoint) {
      final color = boardPoint.color.withOpacity(
        board.selected == boardPoint ? 0.7 : 1,
      );
      final vertices = board.getVerticesForBoardPoint(boardPoint, color);
      canvas.drawVertices(vertices, BlendMode.color, Paint());
    }

    board.forEach(drawBoardPoint);
  }

  // We should repaint whenever the board changes, such as board.selected.
  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    return oldDelegate.board != board;
  }
}

class RectClipper extends CustomClipper<Path> {
  final double ratio;
  final BuildContext textContext;

  RectClipper({this.ratio = 1, this.textContext});

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  double h = 26.0;
  double kToolbarHeight = -26;
  Rect conRect = Rect.zero;
  Rect curRect;

  @override
  Path getClip(Size size) {
    Path mPath = Path();
    if (textContext == null) {
      mPath.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return mPath;
    }
    curRect = getRect(textContext);
    curRect = Rect.fromLTWH(curRect.left, curRect.top, curRect.width * TEPhotoViewWidgetState.scaleValue, curRect.height * TEPhotoViewWidgetState.scaleValue);

    Offset p0 = TEPhotoViewWidgetState.fromViewport(Offset(0, 0));
    Offset p1 = TEPhotoViewWidgetState.fromViewport(Offset(size.width, 0));
    Offset p2 = TEPhotoViewWidgetState.fromViewport(Offset(size.width, curRect.top));
    Offset p3 = TEPhotoViewWidgetState.fromViewport(Offset(curRect.left + curRect.width * ratio, curRect.top));
    Offset p4 = TEPhotoViewWidgetState.fromViewport(Offset(curRect.left + curRect.width * ratio, curRect.bottom));
    Offset p5 = TEPhotoViewWidgetState.fromViewport(Offset(0, curRect.bottom));

    double extras = (kToolbarHeight + h) * TEPhotoViewWidgetState.scaleValue;

    mPath.lineTo(p0.dx, p0.dy);
    mPath.lineTo(p1.dx, p1.dy);
    mPath.lineTo(p2.dx, p2.dy - extras);
    mPath.lineTo(p3.dx, p3.dy - extras);
    mPath.lineTo(p4.dx, p4.dy - extras);
    mPath.lineTo(p5.dx, p5.dy - extras);
    mPath.close();

    return mPath;
  }
}

// END
