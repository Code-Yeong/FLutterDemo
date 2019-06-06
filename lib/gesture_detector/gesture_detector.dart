import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(),
          (AllowMultipleGestureRecognizer instance) {
            instance.onTap = () => print('on tap down');
            instance.onTapDown = (details) => print('on tap down');
            instance.onTapUp = (details) => print('on tap up');
            instance.onTapCancel = () => print('on tap cancel');
          },
        )
      },
      behavior: HitTestBehavior.translucent,
      //Parent Container
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          //Wraps the second container in RawGestureDetector
          child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(
                () => AllowMultipleGestureRecognizer(), //constructor
                (AllowMultipleGestureRecognizer instance) {
                  //initializer
                  instance.onTap = () => print('nested on tap');
                  instance.onTapDown = (details) => print('nested on tap down');
                  instance.onTapUp = (details) => print('nested on tap up');
                  instance.onTapCancel = () => print('nested on tap cancel');
                },
              )
            },
            //Creates the nested container within the first.
            child: Container(
              color: Colors.yellowAccent,
              width: 300.0,
              height: 400.0,
            ),
          ),
        ),
      ),
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    super.rejectGesture(pointer);
    print('pointer : $pointer');
  }

  @override
  void stopTrackingPointer(int pointer) {
    super.stopTrackingPointer(pointer);
  }
}
