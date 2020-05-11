// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_demo/analyze_state/test_state.dart';
import 'package:flutter_demo/utils/render_box_util.dart';
import 'transformations_demo_board.dart';
import 'transformations_demo_edit_board_point.dart';
import 'transformations_demo_gesture_transformable.dart';

// BEGIN transformationsDemo#1

class TransformationsDemo extends StatefulWidget {
  const TransformationsDemo({Key key}) : super(key: key);

  @override
  _TransformationsDemoState createState() => _TransformationsDemoState();
}

class _TransformationsDemoState extends State<TransformationsDemo> with SingleTickerProviderStateMixin {
  // The radius of a hexagon tile in pixels.
  static const _kHexagonRadius = 32.0;

  // The margin between hexagons.
  static const _kHexagonMargin = 1.0;

  // The radius of the entire board in hexagons, not including the center.
  static const _kBoardRadius = 12;

  // 播放时长, 秒
  static const _kAudioDuration = 10;

  AnimationController _animationController;
  Animation<double> _animation;

  bool _reset = false;
  Board _board = Board(
    boardRadius: _kBoardRadius,
    hexagonRadius: _kHexagonRadius,
    hexagonMargin: _kHexagonMargin,
  );

  @override
  void initState() {
    super.initState();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: _kAudioDuration));
    _animationController.addListener(() {
      setState(() {
//        print('val = ${_animationController.value * _kAudioDuration}, avg = $avgTime');
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
//    TextSpan(text: 'and ', style: TextStyle(color: Colors.red)),
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
  ];

  Offset translate = Offset.zero;
  double scaled = 1;

  @override
  Widget build(BuildContext context) {
    final painter = BoardPainter(
      board: _board,
    );

    // The scene is drawn by a CustomPaint, but user interaction is handled by
    // the GestureTransformable parent widget.
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('demo2dTransformationsTitle'),
      ),
      body: Container(
        color: backgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Draw the scene as big as is available, but allow the user to
            // translate beyond that to a visibleSize that's a bit bigger.
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            final visibleSize = Size(size.width * 3, size.height * 2);
//            final visibleSize = Size(size.width, size.height);
            return GestureTransformable(
              onTranslate: (offset){
                translate = offset;
              },
              onScale: (scale){
                scaled = scale;
              },
              reset: _reset,
              onResetEnd: () {
                setState(() {
                  _reset = false;
                });
              },
//              child: CustomPaint(
//                painter: painter,
//              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Wrap(children: _textList),
                    ),
                  ),
                  ClipPath(
                      clipBehavior: Clip.antiAlias,
                      clipper: RectClipper(
                        posotion: position,
                        ratio: (_animationController.value * _kAudioDuration - position * avgTime) / avgTime,
                        cxt: key[position].currentContext,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        color: Colors.transparent,
//                        color: Colors.blue.withOpacity(0.2),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Wrap(children: _textList2),
                        ),
                      )),
                ],
              ),
              boundaryRect: Rect.fromLTWH(
                -visibleSize.width / 2,
                -visibleSize.height / 2,
                visibleSize.width,
                visibleSize.height,
              ),
              // Center the board in the middle of the screen. It's drawn centered
              // at the origin, which is the top left corner of the
              // GestureTransformable.
//              initialTranslation: Offset(size.width / 2, size.height / 2),
              initialTranslation: Offset(0, 0),
              onTapUp: _onTapUp,
              size: size,
              disableRotation: true,
            );
          },
        ),
      ),
      persistentFooterButtons: [resetButton, editButton, startPlay],
    );
  }

  IconButton get resetButton {
    return IconButton(
      onPressed: () {
        setState(() {
          _reset = true;
        });
      },
      tooltip: 'reset',
      color: Theme.of(context).colorScheme.surface,
      icon: const Icon(Icons.replay),
    );
  }

  IconButton get editButton {
    return IconButton(
      onPressed: () {
        if (_board.selected == null) {
          return;
        }
        showModalBottomSheet<Widget>(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                height: 150,
                padding: const EdgeInsets.all(12),
                child: EditBoardPoint(
                  boardPoint: _board.selected,
                  onColorSelection: (color) {
                    setState(() {
                      _board = _board.copyWithBoardPointColor(_board.selected, color);
                      Navigator.pop(context);
                    });
                  },
                ),
              );
            });
      },
      tooltip: 'edit',
      color: Theme.of(context).colorScheme.surface,
      icon: const Icon(Icons.edit),
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

  void _onTapUp(TapUpDetails details) {
    final scenePoint = details.globalPosition;
    final boardPoint = _board.pointToBoardPoint(scenePoint);
    setState(() {
      _board = _board.copyWithSelected(boardPoint);
    });
  }
}

// CustomPainter is what is passed to CustomPaint and actually draws the scene
// when its `paint` method is called.
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
  Rect curRect;
  final BuildContext cxt;
  final int posotion;

  RectClipper({this.ratio = 1, this.curRect, this.cxt, this.posotion});

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  double h = 26.0;

  @override
  Path getClip(Size size) {
    Path mPath = Path();
    if (cxt == null) {
      mPath.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return mPath;
    }
    curRect = getRect(cxt);
    if (posotion == 11) {
      print(ratio);
    }
    mPath.lineTo(0, 0);
    mPath.lineTo(size.width, 0);
    mPath.lineTo(size.width, curRect.top - kToolbarHeight - h);
    mPath.lineTo(curRect.left + curRect.width * ratio, curRect.top - kToolbarHeight - h);
    mPath.lineTo(curRect.left + curRect.width * ratio, curRect.bottom - kToolbarHeight - h);
    mPath.lineTo(0, curRect.bottom - kToolbarHeight - h);
    mPath.close();
//    print('path = ${mPath.getBounds()}');
    return mPath;
  }

//  @override
//  Rect getClip(Size size) {
//    Rect rect = Rect.fromLTWH(0, 0, size.width * ratio, size.height);
//    Rect.
//    print(rect.width * ratio);
//    print(rect.height);
//    return rect;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Rect> oldClipper) {
//    return true;
//  }

}

// END
