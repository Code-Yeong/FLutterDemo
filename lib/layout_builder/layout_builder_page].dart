import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutBuilderPage extends StatefulWidget {
  @override
  _LayoutBuilderPageState createState() => _LayoutBuilderPageState();
}

class _LayoutBuilderPageState extends State<LayoutBuilderPage> {
  int count = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            LayoutBuilder(
              builder: (context, constraint) {
                print("maxHeight = ${constraint.maxHeight}");
                return Container(
                  width: constraint.maxWidth / 2,
                  height: 100.0,
                  color: Colors.red,
                );
              },
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  child: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                            print(count);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(60.0),
                          color: Colors.yellow,
                          child: Center(
                            child: Text('$count'),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.purple,
                child: Text('弹窗内容不可setState变化'),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                            print(count);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(60.0),
                          color: Colors.yellow,
                          child: Center(
                            child: Text('$count'),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
                child: Text('弹窗内容可setState变化'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
