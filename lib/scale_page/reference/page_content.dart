import 'package:flutter/material.dart';
import 'package:flutter_demo/scale_page/reference/photo_view_widget_v2.dart';
import 'package:flutter_demo/utils/render_box_util.dart';

class BodyContent extends StatefulWidget {
  final AnimationController animationController;
  final int audioDuration;

  BodyContent({this.animationController, this.audioDuration});

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  Animation<double> _animation;

  int textCount = 0;
  double avgTime = 0.0;
  int position = 0;
  List<TextSpan> _textSpanList;
  List<GlobalKey> key;
  List<Text> _textList2;
  List<Text> _textList;

  @override
  void initState() {
    _textSpanList = [
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

    key = [
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

    _textList = [
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

    _textList2 = [
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
    _animation = Tween(begin: 0.0, end: 1.0).animate(widget.animationController);
    widget.animationController.addListener(() {
      if (mounted) {
        setState(() {
          position = (widget.animationController.value * widget.audioDuration / avgTime).floor();
          if (position >= _textList.length) {
            position--;
          }
        });
      }
    });
    widget.animationController.addStatusListener((status) {
      if (mounted) {
        if (status == AnimationStatus.completed) {
          widget.animationController.reset();
        }
      }
    });
    textCount = _textList.length;
    avgTime = widget.audioDuration / textCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              ratio: (widget.animationController.value * widget.audioDuration - position * avgTime) / avgTime,
              textContext: key[position].currentContext,
              context: context,
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
    );
  }
}

class RectClipper extends CustomClipper<Path> {
  final double ratio;
  final BuildContext context;
  final BuildContext textContext;

  RectClipper({this.ratio = 1, this.textContext, this.context});

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
    curRect = Rect.fromLTWH(
        curRect.left, curRect.top, curRect.width * TEPhotoViewWidget.of(context).scaleValue, curRect.height * TEPhotoViewWidget.of(context).scaleValue);

    Offset p0 = TEPhotoViewWidget.of(context).fromViewport(Offset(0, 0));
    Offset p1 = TEPhotoViewWidget.of(context).fromViewport(Offset(size.width, 0));
    Offset p2 = TEPhotoViewWidget.of(context).fromViewport(Offset(size.width, curRect.top));
    Offset p3 = TEPhotoViewWidget.of(context).fromViewport(Offset(curRect.left + curRect.width * ratio, curRect.top));
    Offset p4 = TEPhotoViewWidget.of(context).fromViewport(Offset(curRect.left + curRect.width * ratio, curRect.bottom));
    Offset p5 = TEPhotoViewWidget.of(context).fromViewport(Offset(0, curRect.bottom));

    double extras = (kToolbarHeight + h) * TEPhotoViewWidget.of(context).scaleValue;

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
