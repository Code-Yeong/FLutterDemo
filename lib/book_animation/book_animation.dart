import 'package:flutter/material.dart';
import 'package:flutter_demo/book_animation/flip_pannel_widget.dart';

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

  final digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  final imagesList = [
    'assets/images/test.jpeg',
    'assets/images/test2.jpeg',
    'assets/images/test3.jpeg',
    'assets/images/test4.jpeg',
    'assets/images/test_1.jpg',
    'assets/images/test_2.jpg',
    'assets/images/test_3.jpg',
    'assets/images/test_4.jpg'
  ];
  final String image = 'assets/images/test.jpeg';

  final GlobalKey<FlipPanelState> key = GlobalKey<FlipPanelState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('翻书动画'),
        actions: <Widget>[
          RaisedButton(
            child: Text('动画'),
            onPressed: () {
//              setState(() {
//                index = index + 1;
//                notifier.value = index;
//              });
              key.currentState.run();
            },
          )
        ],
      ),
//      body: BookAnimationWidget(
//        picsList: images,
//        notifier: notifier,
//        auto: false,
//        width: 300.0,
//        height: 300.0,
//      ),

//      body: FlipPanel.builder(
//        itemBuilder: (context, index) => Container(
//          color: Colors.black,
//          padding: const EdgeInsets.symmetric(horizontal: 6.0),
//          child: Text(
//            '${digits[index]}',
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
//          ),
//        ),
//        itemsCount: digits.length,
//        period: const Duration(milliseconds: 1000),
//        loop: 0,
//      ),

      body: FlipPanel.builder(
        key: key,
        width: 126.0 * 2,
        height: 175.0,
        firstItemBuilder: (context, index) {
          if (index == 0) {
            return Image.asset(imagesList[index], width: 126.0, height: 175.0);
          }
          return Column(
            children: <Widget>[
              Expanded(child: Image.asset(imagesList[index * 2 - 1], width: 126.0)),
              Container(
                height: 50.0,
                padding: EdgeInsets.only(top: 5.0),
                alignment: Alignment.topCenter,
                color: Colors.white,
                child: Text(
                  'how are you',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
        secondItemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                '${digits[index]}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
              ),
            );
          }
          if (index * 2 >= imagesList.length) {
            return Container();
          }
          return Column(
            children: <Widget>[
              Expanded(child: Image.asset(imagesList[index * 2], width: 126.0)),
              Container(
                height: 50.0,
                padding: EdgeInsets.only(top: 5.0),
                color: Colors.white,
                alignment: Alignment.topCenter,
                child: Text(
                  'how are you',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
        itemsCount: imagesList.length + 1,
        direction: FlipDirection.left,
      ),
    );
  }
}
