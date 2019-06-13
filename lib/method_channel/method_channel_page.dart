import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelPage extends StatefulWidget {
  @override
  _MethodChannelPageState createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  String msg = '';
  static const MethodChannel _channel = const MethodChannel('com.example.flutterdemo/test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Method Channel'),
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                msg = await _channel.invokeMethod('sendMsg');
                setState(() {});
              },
              child: Text('发送')),
          FlatButton(
              onPressed: () async {
                msg = await _channel.invokeMethod('receiveMsg');
                setState(() {});
              },
              child: Text('接收')),
        ],
      ),
      body: Center(
        child: Text('$msg'),
      ),
    );
  }
}
