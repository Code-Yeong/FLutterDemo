import 'package:flutter/material.dart';
import 'package:flutter_demo/gesture_dector2/cover_page.dart';

class GestureDetectorPage extends StatefulWidget {
  @override
  _GestureDetectorPageState createState() => _GestureDetectorPageState();
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  Color btnColor = Colors.grey;
  bool showTopLayer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture'),
      ),
      body: Stack(
//        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Container(
              width: 200.0,
              height: 80.0,
              color: Colors.white,
              child: GestureDetector(
                onTapDown: (_) {
                  print('click:onTapDown');
                  setState(() {
                    btnColor = Colors.red;
//                    showTopLayer = true;
                  });
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CoverPage()));
                },
                onTapUp: (_) {
                  print('click:onTapUp');
                  setState(() {
                    btnColor = Colors.blue;
                  });
                },
                onTap: () {
                  print('click:onTap');
                  setState(() {
                    btnColor = Colors.green;
                  });
                },
                child: Container(
                  width: 200.0,
                  height: 80.0,
                  color: btnColor,
                  alignment: Alignment.center,
                  child: Text('点我'),
                ),
              ),
            ),
          ),
          showTopLayer
              ? Container(
                  width: 250.0,
                  height: 90.0,
                  color: Colors.grey,
                  child: GestureDetector(
                    onTapDown: (_) {
                      print('click2:onTapDown');
                      setState(() {
                        btnColor = Colors.red;
                      });
                    },
                    onTapUp: (_) {
                      print('click2:onTapUp');
                      setState(() {
                        btnColor = Colors.blue;
                      });
                    },
                    onTap: () {
                      print('click2:onTap');
                      setState(() {
                        btnColor = Colors.green;
                      });
                    },
                    child: Container(
                      width: 250.0,
                      height: 90.0,
                      color: btnColor,
                      alignment: Alignment.center,
                      child: Text('我是蒙层'),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
