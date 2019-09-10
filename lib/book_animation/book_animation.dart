import 'package:flutter/material.dart';
import 'package:flutter_demo/book_animation/book_animation_widget.dart';

class BookAnimation extends StatefulWidget {
  @override
  _BookAnimationState createState() => _BookAnimationState();
}

class _BookAnimationState extends State<BookAnimation> {
//  final String key = "animation";
  List<String> images = [
    'assets/images/default_dialogue_teacher_avatar.png',
    'assets/images/test_1.jpg',
    'assets/images/test_2.jpg',
    'assets/images/test_3.jpg',
    'assets/images/test_4.jpg'
  ];
  int index;
  ValueNotifier<int> notifier;

  @override
  void initState() {
    super.initState();
    index = 0;
    notifier = new ValueNotifier<int>(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('翻书动画'),
        actions: <Widget>[
          RaisedButton(
            child: Text('动画'),
            onPressed: () {
              setState(() {
                index = index + 1;
                notifier.value = index;
              });
            },
          )
        ],
      ),
      body: BookAnimationWidget(
        picsList: images,
        notifier: notifier,
        auto: false,
        width: 300.0,
        height: 300.0,
      ),
    );
  }
}
