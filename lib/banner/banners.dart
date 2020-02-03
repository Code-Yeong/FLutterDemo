import 'package:flutter/material.dart';
import 'package:flutter_demo/BasePage.dart';

class BannerPage extends BaseStatelessPage {
  final String title;

  BannerPage({this.title}) : super(title: title);

  @override
  Widget pageContent(BuildContext context) {
    return Container(
//      color: Colors.green,
      child: Column(
        children: <Widget>[
          Banner(
            message: "Banner1",
            location: BannerLocation.topStart,
            child: Container(
              color: Colors.green,
            ),
          ),
          Banner(
            message: "Banner2",
            location: BannerLocation.topEnd,
            color: Colors.blue,
          ),
          Banner(
            message: "Banner4",
            location: BannerLocation.bottomStart,
            child: Container(
              color: Colors.red,
            ),
          ),
          Banner(
            message: "Banner5",
            location: BannerLocation.bottomEnd,
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
