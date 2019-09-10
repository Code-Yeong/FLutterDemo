import 'package:flutter/material.dart';

const double PI = 3.141592654;

/// 以翻书动效来逐张地切换图片
/// [auto] 是否自动播放(首次播放需要手动触发)
/// [v] Matrix4矩阵沿y轴缩放参数
/// [width] 图片宽度
/// [height] 图片高度
/// [duration] 动画持续时长
/// [picsList] 图片url列表
/// [notifier] 当前图片索引号
///
/// Usage:
/// ```
///class BookAnimation extends StatefulWidget {
///  @override
///  _BookAnimationState createState() => _BookAnimationState();
/// }
///
/// class _BookAnimationState extends State<BookAnimation> {
///  final String key = "animation";
///  List<String> images = [
///    'assets/images/default_dialogue_teacher_avatar.png',
///    'assets/images/test_1.jpg',
///    'assets/images/test_2.jpg',
///    'assets/images/test_3.jpg',
///    'assets/images/test_4.jpg'
///  ];
///  int index;
///  ValueNotifier<int> notifier;
///
///  @override
///  void initState() {
///    super.initState();
///    index = 0;
///    notifier = new ValueNotifier<int>(index);
///  }
///
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      appBar: AppBar(
///        title: Text('翻书动画'),
///        actions: <Widget>[
///          RaisedButton(
///            child: Text('动画'),
///            onPressed: () {
///              setState(() {
///                index = index + 1;
///                notifier.value = index;
///              });
///            },
///          )
///        ],
///      ),
///      body: BookAnimationWidget(
///        picsList: images,
///        notifier: notifier,
///        auto: false,
///        width: 300.0,
///        height: 300.0,
///      ),
///    );
///  }
///}
/// ```

class BookAnimationWidget extends StatefulWidget {
  final bool auto;
  final double v;
  final double width;
  final double height;
  final int duration;
  final List<String> picsList;
  final ValueNotifier<int> notifier;

  BookAnimationWidget({this.v = 0.001, this.width, this.height, this.duration = 700, this.picsList, this.auto = false, this.notifier});

  @override
  _BookAnimationWidgetState createState() => _BookAnimationWidgetState();
}

class _BookAnimationWidgetState extends State<BookAnimationWidget> with SingleTickerProviderStateMixin {
  int _curIndex;
  bool _isReversePhase = false;
  Animation<double> _animation;
  AnimationController _controller;

  void nextAction() {
    if (_controller != null) {
      if (!_controller.isAnimating) {
        _curIndex = widget.notifier.value - 1;
        _controller.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _curIndex = widget.notifier.value;
    widget.notifier.addListener(nextAction);
    _controller = new AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversePhase = true;
          _controller.reverse();
        }
        //动画反向执行，反向执行结束后一次动画翻转周期结束。当前数字更新到最新的
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _isReversePhase = false;
            _curIndex++;
          });
          if (widget.auto) {
            _controller.forward();
          }
        }
      })
      ..addListener(() {
        setState(() {});
      });
    //动画数值使用0度角到90度角
    _animation = Tween<double>(begin: 0, end: PI / 2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            widget.picsList[(_curIndex + 1) % widget.picsList.length],
            width: widget.width,
            height: widget.height,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.v)
              ..rotateY(_animation.value),
            child: _isReversePhase
                ? null
                : Image.asset(
                    widget.picsList[_curIndex % widget.picsList.length],
                    width: widget.width,
                    height: widget.height,
                  ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.notifier.removeListener(nextAction);
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
    super.dispose();
  }
}
