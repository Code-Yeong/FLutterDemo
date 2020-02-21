import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/custom_background/custom_decoration.dart';
import 'package:flutter_demo/custom_background/custom_painter.dart';

class CustomDecorationPage extends StatefulWidget {
  @override
  _CustomDecorationPageState createState() => _CustomDecorationPageState();
}

class _CustomDecorationPageState extends State<CustomDecorationPage> {
  ui.Image image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container();
    }
    return Scaffold(
      body: Center(
        child: Container(
//          color: Colors.blue,
          child: Container(
            width: 280.0,
//            decoration: CustomBoxDecoration(
//              color: Colors.red.withOpacity(0.3),
//              image: image,
//            ),
          height: 400.0,
            child: Container(
              width: double.infinity,
              child: CustomPaint(
                painter: MyCustomPainter(image: image),
                child: Text('你哈了'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  init() async {
    image = await getImage('assets/images/test_4.jpg');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  static Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 300, targetHeight: 200);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
