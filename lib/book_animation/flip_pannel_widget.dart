import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
///
typedef Widget IndexedItemBuilder(BuildContext context, int);

///
/// An enum defines all supported directions of [FlipPanel]
///
enum FlipDirection { left, up, right, down }

///
/// A [Widget] provides 3D flipp animation on a panel. The content of each panel
/// is built from [IndexedItemBuilder] or [StreamItemBuilder]
///
/// Note: The size of every panel should be the same and the panel should be
/// a static [Widget] (which is an instance of [StatelessWidget])
///
class FlipPanel<T> extends StatefulWidget {
  final IndexedItemBuilder firstIndexedItemBuilder;
  final IndexedItemBuilder secondIndexedItemBuilder;
  final int itemsCount;
  final Duration duration;
  final int startPage;
  final double spacing;
  final FlipDirection direction;
  final double height;
  final double width;

  FlipPanel({
    Key key,
    this.firstIndexedItemBuilder,
    this.secondIndexedItemBuilder,
    this.itemsCount,
    this.duration,
    this.startPage,
    this.spacing,
    this.direction,
    this.width,
    this.height,
  }) : super(key: key);

  ///
  /// Create a flip panel from iterable source
  ///
  FlipPanel.builder({
    Key key,
    @required IndexedItemBuilder firstItemBuilder,
    @required IndexedItemBuilder secondItemBuilder,
    @required this.itemsCount,
    this.duration = const Duration(milliseconds: 500),
    this.startPage = 0,
    this.spacing = 0.5,
    this.direction = FlipDirection.up,
    this.width,
    this.height,
  })  : assert(firstItemBuilder != null),
        assert(secondItemBuilder != null),
        assert(itemsCount != null),
        assert(startPage * 2 < itemsCount),
        firstIndexedItemBuilder = firstItemBuilder,
        secondIndexedItemBuilder = secondItemBuilder,
        super(key: key);

  @override
  FlipPanelState<T> createState() => FlipPanelState<T>();
}

class FlipPanelState<T> extends State<FlipPanel> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int _currentPage;
  int _pageCount;
  bool _isReversePhase;
  bool _running;
  final _perspective = 0.00;
  final _zeroAngle = 0.0001; // There's something wrong in the perspective transform, I use a very small value instead of zero to temporarily get it around.
  Timer _timer;
  StreamSubscription<T> _subscription;

  Widget _child1, _child2;
  Widget _leftChild1, _leftChild2;
  Widget _rightChild1, _rightChild2;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.startPage;
    _isReversePhase = false;
    _running = false;
    _pageCount = (widget.itemsCount / 2).ceil();

    _controller = new AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversePhase = true;
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _running = false;
        }
      })
      ..addListener(() {
        setState(() {
          _running = true;
        });
      });
    _animation = Tween(begin: _zeroAngle, end: math.pi / 2).animate(_controller);
  }

  void run() {
    _currentPage = (_currentPage + 1) % _pageCount;
    _child1 = null;
    _isReversePhase = false;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_subscription != null) _subscription.cancel();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildChildWidgetsIfNeed(context);

//    return _buildPanel();
    return _buildHPanel();
  }

  void _buildChildWidgetsIfNeed(BuildContext context) {
    Widget makeUpperClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.centerRight,
          widthFactor: 1,
          child: widget,
        ),
      );
    }

    Widget makeLowerClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: 1,
          child: widget,
        ),
      );
    }

    if (_running) {
      if (_child1 == null) {
        _child1 = widget.firstIndexedItemBuilder(context, _currentPage % _pageCount);
        _child2 = null;
      }
      if (_child2 == null) {
        _child2 = widget.secondIndexedItemBuilder(context, (_currentPage) % _pageCount);
        _leftChild2 = makeUpperClip(_child1);
        _rightChild2 = makeLowerClip(_child2);
      }
    } else {
      _child1 = widget.firstIndexedItemBuilder(context, _currentPage % _pageCount);
      _child2 = widget.secondIndexedItemBuilder(context, _currentPage % _pageCount);

      _leftChild1 = _leftChild2 != null ? _leftChild2 : makeUpperClip(_child1);
      _rightChild1 = _rightChild2 != null ? _rightChild2 : makeLowerClip(_child2);

      _leftChild2 = _rightChild2 != null ? _rightChild2 : makeUpperClip(_child2);
      _rightChild2 = _rightChild1 != null ? _rightChild1 : makeLowerClip(_child2);
    }
  }

  Widget _buildLeftFlipPanel() => widget.direction == FlipDirection.left
      ? Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateY(_zeroAngle),
              child: _leftChild1,
            ),
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateY(_isReversePhase ? _animation.value : math.pi / 2),
              child: _leftChild2,
            ),
          ],
        )
      : Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateY(_zeroAngle),
                child: _leftChild2),
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateY(_isReversePhase ? math.pi / 2 : _animation.value),
              child: _leftChild1,
            ),
          ],
        );

  Widget _buildRightFlipPanel() => widget.direction == FlipDirection.left
      ? Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateY(_zeroAngle),
                child: _rightChild2),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateY(_isReversePhase ? math.pi / 2 : -_animation.value),
              child: _rightChild1,
            )
          ],
        )
      : Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateY(_zeroAngle),
                child: _rightChild1),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateY(_isReversePhase ? -_animation.value : math.pi / 2),
              child: _rightChild2,
            )
          ],
        );

  Widget _buildHPanel() {
    return Container(
      height: widget.height,
      width: widget.width,
      child: _running
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildLeftFlipPanel()),
                Padding(
                  padding: EdgeInsets.only(right: widget.spacing),
                ),
                Expanded(child: _buildRightFlipPanel()),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateY(_zeroAngle),
                      child: _leftChild1),
                ),
                Padding(
                  padding: EdgeInsets.only(right: widget.spacing),
                ),
                Expanded(
                  child: Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, _perspective)
                        ..rotateY(_zeroAngle),
                      child: _rightChild1),
                )
              ],
            ),
    );
  }
}
