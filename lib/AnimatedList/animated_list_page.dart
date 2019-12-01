import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/AnimatedList/item.dart';

class AnimatedListPage extends StatefulWidget {
  @override
  _AnimatedListPageState createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  List<ListItem> list = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedList'),
        ),
        body: Container(
          child: AnimatedList(
            key: listKey,
            initialItemCount: list.length,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
                child: ListTile(
                  leading: Text('${list[index].id}'),
                  title: Text('${list[index].name}'),
                  trailing: GestureDetector(
                    onTap: () {
                      deleteItemAt(index);
                    },
                    child: Text('删除'),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            listKey.currentState.insertItem(list.length);
            list.add(ListItem(id: generateId, name: '测试选项'));
          },
          child: Icon(Icons.add_circle, color: Colors.blue, size: 60.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  deleteItemAt(int index) {
    listKey.currentState.removeItem(index, (context, animation) {
      return SizeTransition(
        sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
        child: Container(width: double.infinity, height: 50.0, child: Container(color: Colors.white)),
      );
    });
    list.removeAt(index);
  }

  int get generateId => DateTime.now().millisecondsSinceEpoch;
}
