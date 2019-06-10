import 'package:flutter/material.dart';
import 'package:flutter_demo/hearo_animation/hero_second_page.dart';

class HeroMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero动画'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HeroSecondPage()),
              );
            },
            child: Text('进入下个页面'),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 400.0,
            color: Colors.green,
          ),
          Expanded(
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'heroimage',
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/images/default_dialogue_teacher_avatar.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
