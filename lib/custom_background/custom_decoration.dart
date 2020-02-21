import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBoxDecoration extends Decoration {
  final Color color;
  final ui.Image image;

  CustomBoxDecoration({this.color, this.image});

  @override
  BoxPainter createBoxPainter([onChanged]) {
    // TODO: implement createBoxPainter
    return MyBoxPainter(color: color, image: image);
  }
}

class MyBoxPainter extends BoxPainter {
  final Color color;
  Paint _borderPaint;
  Paint _imagePaint;
  Paint _backgroundPaint;

  MyBoxPainter({this.color, this.image});

  @override
  void dispose() {
//    _backgroundPaint = null;
//    _imagePaint = null;
//    _borderPaint = null;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // TODO: implement paint
    _borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
    _backgroundPaint = Paint()..color = color;
    _imagePaint = Paint()..color = color;
    final Rect rect = offset & configuration.size;
    _drawColor(canvas, rect);
    _drawBorder(canvas, rect);
    _drawImage(canvas, rect);
  }

  // 绘制边框
  _drawBorder(Canvas canvas, Rect rect) {
    Offset start = rect.topLeft;
    Offset end = rect.bottomRight;
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

  final ui.Image image;

  // 绘制背景图片
  _drawImage(Canvas canvas, Rect rect) async {
    canvas.drawImage(image, rect.topLeft, _imagePaint);
  }

  // 绘制背景颜色
  _drawColor(Canvas canvas, Rect rect) {
    canvas.drawRect(rect, _backgroundPaint);
  }
}
