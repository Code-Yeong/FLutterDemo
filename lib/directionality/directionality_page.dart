import 'package:flutter/material.dart';

class DirectionalityDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文本布局'),
      ),
      body: Center(
        child: Container(
          width: 150.0,
          height: 150.0,
          alignment: Alignment.center,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text('hellowdlfjslfjlsafjdkslafjsdkaljhfjdskalhfkjdfdsfdsfdsfdsalshfjkdsahfkadslhfkdslafhks'),
          ),
        ),
      ),
    );
  }
}
