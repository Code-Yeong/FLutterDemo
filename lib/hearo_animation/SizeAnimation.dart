import 'package:flutter/material.dart';

class SizeAnimationPage extends StatefulWidget {
  @override
  _SizeAnimationPageState createState() => _SizeAnimationPageState();
}

class _SizeAnimationPageState extends State<SizeAnimationPage> with SingleTickerProviderStateMixin<SizeAnimationPage>{

  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 500),vsync: this);
    animation = Tween(begin: 0.0, end: 100.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: AnimatedBuilder(animation: animation, builder: (context,child){
          return Container(
            alignment: Alignment.center,
            width: 100.0,
            height: animation.value,
            color: Colors.red,
            child: child,
          );
        },child: Text('123123'),),
      ),
    );
  }
}
