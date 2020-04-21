import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class TEAnimChangeRoleWidget extends StatefulWidget {
  @override
  State createState() => _TEAnimChangeRoleWidgetState();
}

class _TEAnimChangeRoleWidgetState extends State<TEAnimChangeRoleWidget> with SingleTickerProviderStateMixin {
  int _currentTime = 4;
  AnimationController _animController;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _animController = new AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交换角色'),
      ),
      body: Center(
        child: ExchangeRoleWidget(
          width: 120.0,
          backgroundColor: Colors.purple,
          description: "交换角色",
          firstWidget: CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage("assets/images/test2.jpeg"),
          ),
          secondWidget: CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage("assets/images/test3.jpeg"),
          ),
          animController: _animController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_animController.isAnimating) {
            return;
          }
          _animController.forward();
          setState(() {});
          _timer = Timer.periodic(Duration(seconds: 1), (t) {
            setState(() {
              if (_currentTime <= 0) {
                _animController.stop();
                t.cancel();
                _currentTime = 4;
              } else {
                _currentTime--;
              }
            });
          });
        },
        child: _animController.isAnimating
            ? Text(
                '$_currentTime',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            : Text('Start'),
      ),
    );
  }

  @override
  void dispose() {
    if (_animController != null) {
      _animController.stop();
      _animController.dispose();
      _animController = null;
    }
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    super.dispose();
  }
}

///
/// 两个头像水平互换动画
///
/// [width] 宽度、高度
/// [description] 底部描述文案
/// [backgroundColor] 背景色
/// [textColor] 描述文案的颜色
/// [firstWidget],[secondWidget] 需要交换的两个Widget
///
/// Usage:
/// ```
/// ExchangeRoleWidget(
///          width: 120.0,
///          backgroundColor: Colors.purple,
///          description: "交换角色",
///          firstWidget: CircleAvatar(
///            radius: 20.0,
///            backgroundImage: AssetImage("assets/images/test2.jpeg"),
///          ),
///          secondWidget: CircleAvatar(
///            radius: 20.0,
///            backgroundImage: AssetImage("assets/images/test3.jpeg"),
///          ),
///          animController: _animController,
///        ),
/// ```
class ExchangeRoleWidget extends StatefulWidget {
  final double width;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  final Widget firstWidget;
  final Widget secondWidget;
  final AnimationController animController;

  ExchangeRoleWidget({
    this.width,
    this.description,
    this.backgroundColor,
    this.textColor = const Color(0xffffffff),
    this.firstWidget,
    this.secondWidget,
    this.animController,
  });

  @override
  State createState() => _TEExchangeRoleWidget();
}

class _TEExchangeRoleWidget extends State<ExchangeRoleWidget> {
  int _finishedCount = 0;
  Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    bool _changeLayer = _finishedCount % 2 == 1;
    return Container(
      width: widget.width,
      height: widget.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor ?? Colors.black.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _changeLayer
                    ? Positioned(
                        left: _animation.value,
                        child: widget.firstWidget,
                      )
                    : Container(),
                _changeLayer
                    ? Positioned(
                        right: _animation.value,
                        child: widget.secondWidget,
                      )
                    : Container(),
                !_changeLayer
                    ? Positioned(
                        right: _animation.value,
                        child: widget.secondWidget,
                      )
                    : Container(),
                !_changeLayer
                    ? Positioned(
                        left: _animation.value,
                        child: widget.firstWidget,
                      )
                    : Container(),
              ],
            ),
          ),
          widget.description != null ? SizedBox(height: 8.0) : Container(),
          widget.description != null
              ? Text(
                  widget.description,
                  style: TextStyle(color: widget.textColor, fontSize: 14.0, decoration: TextDecoration.none),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animation = new Tween(begin: 18.0, end: 62.0).animate(widget.animController)
      ..addListener(_updateListener)
      ..addStatusListener(_animationStatusListener);
  }

  _updateListener() {
    setState(() {});
  }

  _animationStatusListener(status) {
    if (status == AnimationStatus.completed) {
      _finishedCount++;
      widget.animController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      widget.animController.forward();
    }
  }

  @override
  void dispose() {
    _animation.removeListener(_updateListener);
    _animation.removeStatusListener(_animationStatusListener);
    _animation = null;
    super.dispose();
  }
}
