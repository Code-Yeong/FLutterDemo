import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_pageview/CustomPageViewWidget.dart';

class TestCustomPageView extends StatefulWidget {
  @override
  _TestCustomPageViewState createState() => _TestCustomPageViewState();
}

class _TestCustomPageViewState extends State<TestCustomPageView> {
  final List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 10; i++) {
      dataList.add('${i * 100}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义PageView'),
      ),
      body: Container(
        child: CustomPageViewWidget(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(20.0),
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Text('${dataList[index]}'),
            );
          },
        ),
      ),
    );
  }
}
