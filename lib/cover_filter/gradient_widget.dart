import 'dart:math';

import 'package:flutter/material.dart';

///
/// 朝上的渐变遮罩（从下至上逐渐透明）
///
/// [height] 遮罩可见部分高度
/// [radius] 遮罩底部左右两个角的弧度
/// [color] 遮罩背景色
/// Usage:
/// ```
///   Stack(
///      alignment: Alignment.center,
///      children: <Widget>[
///        Positioned(
///          child: Container(
///            color: Colors.black,
///            height: double.infinity,
///          ),
///        ),
///        Positioned(
///          bottom: 0.0,
///          left: 0.0,
///          right: 0.0,
///          child: GradientMaskWidget(),
///        ),
///      ],
///    )
///
/// ```

class GradientMaskWidget extends StatelessWidget {
  final double height;
  final double radius;
  final Color color;

  GradientMaskWidget({
    this.height = 32.0,
    this.radius = 16.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: MyShapeBorder(
          radius: radius,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: color, blurRadius: 20.0, spreadRadius: 20.0, offset: Offset(1.0, 1.0)),
            ],
          ),
          height: height,
        ),
      ),
    );
  }
}

class MyShapeBorder extends CustomClipper<Path> {
  final double radius;

  MyShapeBorder({this.radius});

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0, -80);
    path.lineTo(0, size.height - radius);
    path.arcTo(Rect.fromCircle(center: Offset(radius + 0, size.height - radius), radius: radius), pi, -pi / 2, false);
    path.lineTo(size.width - radius - 0, size.height);
    path.arcTo(Rect.fromCircle(center: Offset(size.width - radius - 0, size.height - radius), radius: radius), pi / 2, -pi / 2, false);
    path.lineTo(size.width - 0, -80);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
