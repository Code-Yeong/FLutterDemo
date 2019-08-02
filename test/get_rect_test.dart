import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/render_box_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('test getRect methods',(){
    Builder(builder: (context){
      print(getRect(context));
      return null;
    });
  });
}