import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 0;

  double _s = 0;
  double _e = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("slider"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('${_value.toInt()}'),
            Slider(
              value: _value,
              max: 100,
              min: 0,
              divisions: 100,
              onChanged: (v) {
                setState(() {
                  _value = v;
                });
              },
            ),
            SizedBox(height: 100.0),
            Text('${_s.toInt()} -- ${_e.toInt()}'),
            RangeSlider(
                values: RangeValues(_s, _e),
                min: 0,
                max: 100,
                onChanged: (value) {
                  _s = value.start;
                  _e = value.end;
                  setState(() {});
                })
          ],
        ),
      ),
    ));
  }
}
