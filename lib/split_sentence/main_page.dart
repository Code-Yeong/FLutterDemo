import 'package:flutter/material.dart';
import 'package:flutter_demo/split_sentence/split_sentence.dart';

class SplitSentencePage extends StatefulWidget {
  @override
  _SplitSentencePageState createState() => _SplitSentencePageState();
}

class _SplitSentencePageState extends State<SplitSentencePage> {
  String text = "'sorry,'we' haven't go the dvds'";
  WordSeg seg;

  @override
  void initState() {
    super.initState();
    seg = new WordSeg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("句子分割"),
        actions: <Widget>[
          RaisedButton(
            child: Text("分割"),
            onPressed: () {
              setState(() {
                seg.parseContent(text);
                print('finished---');
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: Text(
                '原文: $text',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              alignment: Alignment.center,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: seg.segs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${index + 1}:  ${seg.segs[index].word}'),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
