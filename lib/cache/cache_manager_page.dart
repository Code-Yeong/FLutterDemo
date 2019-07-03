import 'package:flutter/material.dart';

class CacheManagerPage extends StatefulWidget {
  @override
  _CacheManagerPageState createState() => _CacheManagerPageState();
}

class _CacheManagerPageState extends State<CacheManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('缓存管理模块'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
//                print(object)
              },
              child: Text('开始下载'),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('停止下载'),
            ),
          ],
        ),
      ),
    );
  }
}
