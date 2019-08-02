import 'package:flutter/material.dart';
import 'package:flutter_demo/BasePage.dart';

class BannerPage extends BaseStatelessPage {
  final String title;

  BannerPage({this.title}) : super(title: title);

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: <Widget>[
          Banner(
            message: "Banner",
            location: BannerLocation.topStart,
            child: Container(
              color: Colors.red,
            ),
          ),
          Banner(
            message: "Banner",
            location: BannerLocation.topEnd,
            child: Container(
              color: Colors.red,
            ),
          ),
          Banner(
            message: "Banner",
            location: BannerLocation.topStart,
            child: Container(
              color: Colors.red,
            ),
          ),
          Banner(
            message: "Banner",
            location: BannerLocation.bottomStart,
            child: Container(
              color: Colors.red,
            ),
          ),
          Banner(
            message: "Banner",
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
