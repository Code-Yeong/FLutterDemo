import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('覆盖层'),
      ),
      body: GestureDetector(
        onTapDown: (_){
          print('我是蒙层的：onTapDown');
        },
        onTapUp: (_){
          print('我是蒙层的：onTapUp');
        },
        onTap: (){
          print('我是蒙层的：onTap');
        },
        child: Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text('我是蒙层'),
        ),
      ),
    );
  }
}
