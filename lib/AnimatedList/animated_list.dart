import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  @override
  _AnimatedListPageState createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  List<String> list = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list.add('Item $i');
    }
    anim2 = Tween(begin: 0, end: 1);
  }

  Tween<int> anim2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Add'),
                    onPressed: () {
                      list.insert(0, 'new');
                      listKey.currentState.insertItem(0);
                    },
                  ),
                  RaisedButton(
                    child: Text('Del'),
                    onPressed: () {
                      if (list.length > 0) {
                        listKey.currentState.removeItem(0, (context, animation) {
                          return SizeTransition(
                            sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
                            child: Container(
                              width: double.infinity,
                              height: 50.0,
                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                              child: list.length > 0
                                  ? Container(
                                      color: Colors.cyanAccent,
                                      child: Text(
                                        '${list[0]}',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container(),
                            ),
                          );
                        });
                        list.removeAt(0);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: list.length > 0
                    ? AnimatedList(
                        key: listKey,
                        initialItemCount: list.length,
                        itemBuilder: (context, index, animation) {
                          return SizeTransition(
                            sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
                            child: ListItem(text: list[index]),
                          );
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;

  ListItem({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
      child: Container(
        color: Colors.cyanAccent,
        child: Text(
          '$text',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
