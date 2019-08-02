import 'dart:ui';

import 'package:flutter/material.dart';

class TEAnimChangeRoleWidget extends StatefulWidget {
  @override
  State createState() => _TEAnimChangeRoleWidgetState();
}

class _TEAnimChangeRoleWidgetState extends State<TEAnimChangeRoleWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TEMyCustomPainter(),
      foregroundPainter: null,
      child: Text("paiter"),
    );
  }
}

class _TEMyCustomPainter extends CustomPainter {
//  Paint _paint = new Paint();

  @override
  void paint(Canvas canvas, Size size) {
//    canvas.drawImage(instantiateImageCodec(), Offset(size.width/2, size.height/2), _paint)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
