import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  final ui.Image image;

  MyCustomPainter({this.image});

  Paint imagePaint;
  Paint _borderPaint;

  @override
  void paint(Canvas canvas, Size size) {
    imagePaint = Paint();
    // TODO: implement paint
    _borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
//    _drawColor(canvas);
    _drawBorder(canvas, size);
    _drawImage(canvas);
  }

  _drawImage(Canvas canvas) {
    canvas.drawImage(image, Offset(0, 0), imagePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  // 绘制边框
  _drawBorder(Canvas canvas, Size size) {
    Offset start = Offset(0, 0);
    Offset end = Offset(size.width, size.height);
    for (int i = 0; i < 2; i++) {
      Path path1 = Path();
      double shift = 5.0 + 2 * i;
      path1.moveTo(start.dx + shift, start.dy + shift);
      path1.lineTo(end.dx - shift, start.dy + shift);
      path1.lineTo(end.dx - shift, end.dy - shift);
      path1.lineTo(start.dx + shift, end.dy - shift);
      path1.close();
      canvas.drawPath(path1, _borderPaint);
    }
  }

//  // 绘制背景颜色
//  _drawColor(Canvas canvas, Rect rect) {
//    canvas.drawRect(rect, _backgroundPaint);
//}
}
