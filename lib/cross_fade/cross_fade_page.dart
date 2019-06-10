import 'package:flutter/material.dart';

class CrossFadeAnimation extends StatefulWidget {
  @override
  _CrossFadeAnimationState createState() => _CrossFadeAnimationState();
}

class _CrossFadeAnimationState extends State<CrossFadeAnimation> {
  bool _first = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交叉动画'),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _first = !_first;
              });
              print('isFirst:$_first');
            },
            child: Text('change'),
          ),
        ],
      ),
      body: Center(
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
          secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
          crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
