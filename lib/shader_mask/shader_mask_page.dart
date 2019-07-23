import 'package:flutter/material.dart';
import 'package:flutter_demo/BasePage.dart';

class ShaderMaskPage extends BaseStatelessPage {
  final String title;

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        width: 300.0,
        height: 200.0,
        color: Colors.green,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.topLeft,
              radius: 0.5,
              colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: const Text('I’m burning the memories'),
        ),
      ),
    );
  }

  ShaderMaskPage({this.title}) : super(title: title);
}
