import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpliceBackgroundImagePage extends StatefulWidget {
  @override
  _SpliceBackgroundImagePageState createState() => _SpliceBackgroundImagePageState();
}

class _SpliceBackgroundImagePageState extends State<SpliceBackgroundImagePage> {
  int _index = 0;
  List<Widget> widgets = [
    SpliceBackgroundImage1(height: 200.0),
    SpliceBackgroundImage2(
      height: 800.0,
    ),
    SpliceBackgroundImage3(
      height: 300.0,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("背景图片拼接"),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _index = (_index + 1) % widgets.length;
              });
            },
            child: Text('切换'),
          )
        ],
      ),
      body: Center(
        child: widgets[_index],
      ),
    );
  }
}

class SpliceBackgroundImage1 extends StatelessWidget {
  final double width;
  final double height;

  SpliceBackgroundImage1({this.width = double.infinity, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
//      color: Colors.red,
      child: Container(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              'assets/svg/bg_top.svg',
              fit: BoxFit.contain,
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/svg/bg_center.svg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: SvgPicture.asset(
                'assets/svg/bg_bottom.svg',
                fit: BoxFit.contain,
              ),
//            color: Colors.green,
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}

class SpliceBackgroundImage2 extends StatelessWidget {
  final double width;
  final double height;

  SpliceBackgroundImage2({this.width = double.infinity, this.height = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: height,
      color: Color(0xFF8B5FFE),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 120.0, left: 10.0 + 15.9, right: 10.0 + 15, bottom: 10.0 + 50),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Color(0xFF8B5FFE)), borderRadius: BorderRadius.all(Radius.circular(16.0)), color: Colors.white),
              child: Text('fdslfjdslajfldksjfldsjflds'),
            ),
            margin: EdgeInsets.only(top: 120.0, left: 15.9, right: 15.0, bottom: 50.0),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/svg/report_bg_layer_3.svg',
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/svg/report_bg_layer_1.svg',
            ),
          ),
          Positioned(
            left: 0,
            top: 200,
            child: SvgPicture.asset(
              'assets/svg/report_bg_layer_2.svg',
            ),
          ),
        ],
      ),
    );
  }
}

class SpliceBackgroundImage3 extends StatelessWidget {
  final double height;

  SpliceBackgroundImage3({this.height = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF8B5FFE),
      child: ListView(
        children: <Widget>[
          Container(
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  margin: EdgeInsets.only(top: 120.0, left: 15.9, right: 15.0, bottom: 50.0),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/report_bg_layer_3.png',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.0 + 120, left: 10.0 + 15.9, right: 10.0 + 15, bottom: 10.0 + 50),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Color(0xFF8B5FFE)),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/report_bg_layer_1.png',
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 200,
                  child: Image.asset(
                    'assets/images/report_bg_layer_2.png',
                    scale: 2.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
