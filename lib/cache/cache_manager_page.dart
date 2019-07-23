import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/cache/cache.dart';
import 'package:flutter_demo/cache/cache_manager.dart';

class CacheManagerPage extends StatefulWidget {
  @override
  _CacheManagerPageState createState() => _CacheManagerPageState();
}

class _CacheManagerPageState extends State<CacheManagerPage> {
  @override
  Widget build(BuildContext context) {
    CacheManager cache= CacheManager(CacheType.permanent,"dialogue",fileName: "testfile");
    cache.init();
    return Scaffold(
      appBar: AppBar(
        title: Text('缓存管理模块'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async{
//                print(object)

                String result = await cache.writeCache("myFirstTextFile222.txt");
                print('create success: $result');
//                String path = await cache.writeCache('myTestFile.txt');
//                print('cacehd file:$path');
//                String path2 = cache.readCache('myTestFile.txt');
//                print('read result:$path2');
              },
              child: Text('写新缓存'),
            ),
            RaisedButton(
              onPressed: () {
                String fileName = cache.readCache("myFirstTextFile333.txt");
                print('read result:$fileName');
              },
              child: Text('读缓存'),
            ),
            RaisedButton(
              onPressed: () async{
                String fileName = await cache.cache(cache.readCache("myFirstTextFile222.txt"),"myFirstTextFile333.txt");
                print('移动之后的缓存位置:$fileName');
              },
              child: Text('从本地写缓存'),
            ),
            RaisedButton(
              onPressed: () {
                String fileName = cache.readCache("myFirstTextFile222.txt");
                print('read result:$fileName');
              },
              child: Text('清空缓存'),
            ),
          ],
        ),
      ),
    );
  }
}
