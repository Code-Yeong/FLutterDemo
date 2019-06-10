import 'package:flutter/material.dart';
import 'package:flutter_demo/cover_filter/gradient_widget.dart';

class CoverFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('渐变遮罩'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Container(
                color: Colors.black,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: GradientMaskWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
