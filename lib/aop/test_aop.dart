import 'package:flutter/material.dart';

class TestAopDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试AOP')),
      body: Container(
        child: RaisedButton(
          onPressed: () {
            print('before add');
            print('result: ${add(1, 2)}');
            print('after add');
          },
          child: Text('测试按钮'),
        ),
      ),
    );
  }

  add(a, b){
    return a + b;
  }
}
