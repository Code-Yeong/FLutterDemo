import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlutterTTSPage extends StatefulWidget {
  @override
  _FlutterTTSState createState() => _FlutterTTSState();
}

class _FlutterTTSState extends State<FlutterTTSPage> {
  List<String> sentences = ["Hello Kitty", "Hello Tom", "Today is a good day"];
  FlutterTts flutterTts;


  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setPitch(5);
    flutterTts.setSpeechRate(0.8);
//    flutterTts.setVoice(voice);
  flutterTts.setVolume(0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TTS'),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${sentences[index]}'),
              onTap: (){
                flutterTts.speak(sentences[index]);
              },
            );
          },
          itemCount: sentences.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
