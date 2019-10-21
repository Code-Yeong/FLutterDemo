import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TestPage1')),
      body: Container(
        child: RaisedButton(
          onPressed: () {
            Fluttertoast.showToast(msg: '当前是有滑动手势？:${Navigator.of(context).userGestureInProgress}');
          },
          child: Text('按钮1'),
        ),
      ),
    );
  }
}
