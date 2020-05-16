// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/scale_page/reference/page_content.dart';
import 'package:flutter_demo/scale_page/reference/photo_view_widget_v2.dart';

import 'transformations_demo_board.dart';
import 'transformations_demo_edit_board_point.dart';

// BEGIN transformationsDemo#1

class TransformationsDemo extends StatefulWidget {
  const TransformationsDemo({Key key}) : super(key: key);

  @override
  _TransformationsDemoState createState() => _TransformationsDemoState();
}

class _TransformationsDemoState extends State<TransformationsDemo> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: _kAudioDuration));
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  PageController _pageController;

  // 播放时长, 秒
  static const _kAudioDuration = 10;

  AnimationController _animationController;

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
//          allowImplicitScrolling: true,
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
                setState(() {});
                if (direction == ScrollDirection.forward) {
                  _animationController.stop();
                  _animationController.reset();
                  _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else {
                  _animationController.stop();
                  _animationController.reset();
                  _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                }
              },
              child: BodyContent(
                animationController: _animationController,
                audioDuration: _kAudioDuration,
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
          itemCount: 10,
        ),
      ),
      persistentFooterButtons: [resetButton, startPlay],
    );
  }

  IconButton get resetButton {
    return IconButton(
      onPressed: () {
//        print('state = ${TEPhotoViewWidget.of(childContext)}');
//        childContext.dependOnInheritedWidgetOfExactType()
//        TEPhotoViewWidget.of(childContext).animateResetInitialize();
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

// END
