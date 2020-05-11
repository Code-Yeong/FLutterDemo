import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScalePage extends StatefulWidget {
  @override
  _ScalePageState createState() => _ScalePageState();
}

class _ScalePageState extends State<ScalePage> {
  @override
  Widget build(BuildContext context) {
    return TransformText();
  }
}

class TransformText extends StatefulWidget {
  TransformText({Key key}) : super(key: key); // changed

  @override
  _TransformTextState createState() => _TransformTextState();
}

class _TransformTextState extends State<TransformText> with SingleTickerProviderStateMixin{
  double scale = 0.0;

  double progress = 0.0;


  AnimationController _controller;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
//    final ValueNotifier<double> notifier = ValueNotifier(1);


    return Scaffold(
      appBar: AppBar(
        title: Text('Single finger Rotate text'), // changed
      ),
      body: Center(
//        child: MatrixGestureDetector(
        child: GestureDetector(
//          onMatrixUpdate: (m, tm, sm, rm) {
//            notifier.value = m;
//          },
          onScaleUpdate: (details) {
            notifier.value = Matrix4.identity();
            notifier.value.scale(details.scale);
          },
          child: AnimatedBuilder(
            animation: notifier,
            builder: (ctx, child) {
              return Transform(
                transform: notifier.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 50),
                        child: Transform.scale(
                          scale: 1, // make this dynamic to change the scaling as in the basic demo
                          origin: Offset(0.0, 0.0),
                          child: Container(
                            height: 100,
                            child: Text(
                              "Two finger to zoom!!",
                              style: TextStyle(fontSize: 26, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          'assets/svg/bg_top.svg',
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          'assets/svg/bg_top.svg',
                          fit: BoxFit.contain,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
