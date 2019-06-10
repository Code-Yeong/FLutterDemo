import 'package:flutter/material.dart';

class HeroSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero动画2级页面'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'heroimage',
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/images/default_dialogue_teacher_avatar.png'),
              ),
            ),
          ),
          Container(
            height: 400.0,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
