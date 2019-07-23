import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

/// WebView 使用实例
/// Dart 层的webView通过 javascriptChannels 与 js 桥接通信

class _WebViewPageState extends State<WebViewPage> {
  final String _initialUrl = 'http://www.baidu.com';

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: Container(
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: _initialUrl,
              onWebViewCreated: (controller){
                _controller = controller;
              },
              onPageFinished: (url){
                print('on page finished:$url');
              },
//              debuggingEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[JavascriptChannel(name: 'demoBridge', onMessageReceived: (msg){})].toSet(),
            ),
          ],
        )
      ),
    );
  }
}
