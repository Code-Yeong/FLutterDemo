import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/render_box_util.dart';

class RandomPositionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('自由位置弹框'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Rect rect = getRect(context);
                    print("bottom:${rect.bottom}");
                    Navigator.push(
                      context,
                      MyPopupRoute(
                        offset: rect.bottom,
                        transitionDuration: Duration(
                          milliseconds: 0,
                        ),
                        barrierColor: Colors.white,
                        barrierLabel: 'label',
                        barrierDismissible: false,
                      ),
                    );
                  },
                  child: Container(
                    height: 100.0,
                    width: double.infinity,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text('head text'),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            child: Text('测试 $index'),
          );
        },
      ),
    );
  }
}

class MyPopupRoute<T> extends PopupRoute<T> {
  MyPopupRoute({
    this.offset,
    this.barrierColor,
    this.barrierDismissible,
    this.barrierLabel,
    this.transitionDuration,
  });

  final bool barrierDismissible;
  final String barrierLabel;
  final Color barrierColor;
  final Duration transitionDuration;
  final double offset;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 200.0,
          margin: EdgeInsets.only(top: offset),
          color: Colors.red,
          child: _ListWidget(),
        ),
      ),
    );
  }
}
