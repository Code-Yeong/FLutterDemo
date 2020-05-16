//import 'dart:math';
//
//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:vector_math/vector_math.dart' show Vector2;
//import 'package:vector_math/vector_math_64.dart' show Vector3;
//
/////
///// 1、图片预览缩放
/////
///// [child] 要展示的Widget
///// [size] child大小，限定可视区域
///// [maxScale],[minScale] 最大放大倍数,最小缩小倍数
///// [initialRotation] 初始旋转位置
///// [initialTranslation] 初始平移位置
///// [initialScale] 初始放大倍数
///// [onScrollTo] 水平滑动回调函数，返回值是[ScrollDirection.forward]或[ScrollDirection.reverse]，左右翻页时使用
/////
///// 2、坐标转换
///// Offset newViewportPoint = TEPhotoViewWidgetState.fromViewport(originalViewportPoint)
/////
///// 3、用法
///// PageView.builder(
/////    physics: NeverScrollableScrollPhysics(),
/////    allowImplicitScrolling: true,
/////    controller: _pageController,
/////    itemBuilder: (context, index) {
/////      return TEPhotoViewWidget(
/////        onScrollTo: (direction) {
/////          // 上一页 or 下一页
/////        },
/////        child: Stack(
/////          alignment: AlignmentDirectional.center,
/////          children: <Widget>[
/////            //......
/////          ],
/////        ),
/////        size: MediaQuery.of(context).size,
/////      );
/////    },
/////    itemCount: 10,
/////  )
/////
//
//@immutable
//class TEPhotoViewWidget extends StatefulWidget {
//  const TEPhotoViewWidget({
//    this.key,
//    @required this.child,
//    @required this.size,
//    this.maxScale = 2.5,
//    this.minScale = 0.8,
//    this.initialTranslation = const Offset(0.0, 0.0),
//    this.initialScale,
//    this.initialRotation,
//    this.disableTranslation = false,
//    this.disableScale = false,
//    this.disableRotation = true,
//    this.onTapDown,
//    this.onTapUp,
//    this.onTap,
//    this.onPanDown,
//    this.onPanStart,
//    this.onPanUpdate,
//    this.onPanEnd,
//    this.onPanCancel,
//    this.onScaleStart,
//    this.onScaleUpdate,
//    this.onScaleEnd,
//    this.onScrollTo,
//  })  : assert(child != null),
//        assert(size != null),
//        assert(minScale != null),
//        assert(minScale > 0),
//        assert(disableTranslation != null),
//        assert(disableScale != null),
//        assert(disableRotation != null),
//        super(key: key);
//
//  final Widget child;
//  final Size size;
//
//  final GestureTapDownCallback onTapDown;
//  final GestureTapUpCallback onTapUp;
//  final GestureTapCallback onTap;
//  final GestureDragDownCallback onPanDown;
//  final GestureDragStartCallback onPanStart;
//  final GestureDragUpdateCallback onPanUpdate;
//  final GestureDragEndCallback onPanEnd;
//  final GestureDragCancelCallback onPanCancel;
//  final GestureScaleStartCallback onScaleStart;
//  final GestureScaleUpdateCallback onScaleUpdate;
//  final GestureScaleEndCallback onScaleEnd;
//  final double maxScale;
//  final double minScale;
//  final bool disableTranslation;
//  final bool disableScale;
//  final bool disableRotation;
//  final Offset initialTranslation;
//  final double initialScale;
//  final double initialRotation;
//  final Key key;
//
//  //self define
//  final ValueChanged<ScrollDirection> onScrollTo;
//
//  @override
//  TEPhotoViewWidgetState createState() => TEPhotoViewWidgetState();
//}
//
//// A single user event can only represent one of these gestures. The user can't
//// do multiple at the same time, which results in more precise transformations.
//enum _GestureType {
//  translate,
//  scale,
//  rotate,
//}
//
//// This is public only for access from a unit test.
//class TEPhotoViewWidgetState extends State<TEPhotoViewWidget> with TickerProviderStateMixin {
//  Animation<Offset> _animation;
//  AnimationController _controller;
//  Animation<Matrix4> _animationReset;
//  AnimationController _controllerReset;
//  bool _handledChangePage = false;
//
//  Offset _translateFromScene; // Point where a single translation began.
//  double _scaleStart; // Scale value at start of scaling gesture.
//  double _rotationStart = 0; // Rotation at start of rotation gesture.
//  Rect _boundaryRect;
//  static Matrix4 _transform = Matrix4.identity();
//  double _currentRotation = 0;
//  _GestureType gestureType;
//
//  // The transformation matrix that gives the initial home position.
//  Matrix4 get _initialTransform {
//    var matrix = Matrix4.identity();
//    if (widget.initialTranslation != null) {
//      matrix = matrixTranslate(matrix, widget.initialTranslation);
//    }
//    if (widget.initialScale != null) {
//      matrix = matrixScale(matrix, widget.initialScale);
//    }
//    if (widget.initialRotation != null) {
//      matrix = matrixRotate(matrix, widget.initialRotation, Offset.zero);
//    }
//    return matrix;
//  }
//
//  // Return the scene point at the given viewport point.
////  static Offset fromViewport(Offset viewportPoint, Matrix4 transform) {
//  static Offset fromViewport(Offset viewportPoint, {Matrix4 transform}) {
//    final inverseMatrix = Matrix4.inverted(transform ?? _transform);
//    final untransformed = inverseMatrix.transform3(Vector3(
//      viewportPoint.dx,
//      viewportPoint.dy,
//      0,
//    ));
//    return Offset(untransformed.x, untransformed.y);
//  }
//
//  // Get the offset of the current widget from the global screen coordinates.
//  // TODO(justinmc): Protect against calling this during first build.
//  static Offset getOffset(BuildContext context) {
//    final renderObject = context.findRenderObject() as RenderBox;
//    return renderObject.localToGlobal(Offset.zero);
//  }
//
//  static double get scaleValue => _transform.getMaxScaleOnAxis();
//
//  @override
//  void initState() {
//    super.initState();
//    _boundaryRect = Offset.zero & widget.size;
//    _transform = _initialTransform;
//    _controller = AnimationController(vsync: this);
//    _controllerReset = AnimationController(vsync: this);
//  }
//
//  @override
//  void didUpdateWidget(TEPhotoViewWidget oldWidget) {
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // A GestureDetector allows the detection of panning and zooming gestures on
//    // its child, which is the CustomPaint.
//    return GestureDetector(
//      behavior: HitTestBehavior.opaque,
//      // Necessary when translating off screen
//      onTapDown: widget.onTapDown == null
//          ? null
//          : (details) {
//              widget.onTapDown(TapDownDetails(
//                globalPosition: fromViewport(details.globalPosition - getOffset(context)),
//              ));
//            },
//      onTapUp: widget.onTapUp == null
//          ? null
//          : (details) {
//              widget.onTapUp(TapUpDetails(
//                globalPosition: fromViewport(details.globalPosition - getOffset(context)),
//              ));
//            },
//      onTap: widget.onTap,
//      onPanDown: widget.onPanDown == null
//          ? null
//          : (details) {
//              widget.onPanDown(DragDownDetails(
//                globalPosition: fromViewport(details.globalPosition - getOffset(context)),
//              ));
//            },
//      onPanStart: widget.onPanStart == null
//          ? null
//          : (details) {
//              widget.onPanStart(DragStartDetails(
//                globalPosition: fromViewport(details.globalPosition - getOffset(context)),
//              ));
//            },
//      onPanUpdate: widget.onPanUpdate == null
//          ? null
//          : (details) {
//              widget.onPanUpdate(DragUpdateDetails(
//                globalPosition: fromViewport(details.globalPosition - getOffset(context)),
//              ));
//            },
//      onPanEnd: widget.onPanEnd,
//      onPanCancel: widget.onPanCancel,
//      onScaleEnd: _onScaleEnd,
//      onScaleStart: _onScaleStart,
//      onScaleUpdate: _onScaleUpdate,
//      child: ClipRect(
//        // The scene is panned/zoomed/rotated using this Transform widget.
//        child: Transform(
//          transform: _transform,
//          child: Container(
//            child: widget.child,
//            height: widget.size.height,
//            width: widget.size.width,
//          ),
//        ),
//      ),
//    );
//  }
//
//  // Return a new matrix representing the given matrix after applying the given
//  // translation.
//  Matrix4 matrixTranslate(Matrix4 matrix, Offset translation, {bool boundaryRestrict = true}) {
//    if (widget.disableTranslation || translation == Offset.zero) {
//      return matrix;
//    }
//
//    final scale = _transform.getMaxScaleOnAxis(); //倍数
//    final viewportBoundaries = Rect.fromLTRB(_boundaryRect.left, _boundaryRect.top, _boundaryRect.right, _boundaryRect.bottom);
//    final translationBoundaries = Rect.fromLTRB(
//      -scale * viewportBoundaries.right,
//      -scale * viewportBoundaries.bottom,
//      -scale * viewportBoundaries.left,
//      -scale * viewportBoundaries.top,
//    );
//
//    if (boundaryRestrict) {
//      final nextMatrix = matrix.clone()..translate(translation.dx, translation.dy);
//      final nextTranslationVector = nextMatrix.getTranslation();
//      final nextTranslation = Offset(nextTranslationVector.x, nextTranslationVector.y);
//      if (gestureType == _GestureType.translate) {
//        bool inBoundaries = translationBoundaries.contains(Offset(nextTranslation.dx, nextTranslation.dy));
//        // 限制左上角
//        if (!inBoundaries) {
//          // 触边时触发向左翻页动作
//          _onScrollTo(translation);
//          return matrix;
//        }
//        Offset br = fromViewport(Offset(_boundaryRect.right, _boundaryRect.bottom), transform: nextMatrix);
//        // 限制右下角
//        if (br.dx > _boundaryRect.right || br.dy > _boundaryRect.bottom) {
//          // 触边时触发向右翻页动作
//          _onScrollTo(translation);
//          return matrix;
//        }
//      }
//      return nextMatrix;
//    } else {
//      // 收缩按焦点对齐
//      matrix.translate(translation.dx, translation.dy);
//      return matrix;
//    }
//  }
//
//  _onScrollTo(Offset translation) {
//    if (_transform.getMaxScaleOnAxis() <= 1.2 && widget.onScrollTo != null) {
//      if (translation.dx > kTouchSlop) {
//        if (!_handledChangePage) {
//          _handledChangePage = true;
//          widget.onScrollTo(ScrollDirection.reverse);
//        }
//      } else if (translation.dx < -kTouchSlop) {
//        if (!_handledChangePage) {
//          _handledChangePage = true;
//          widget.onScrollTo(ScrollDirection.forward);
//        }
//      }
//    }
//  }
//
//// Return a new matrix representing the given matrix after applying the given
//// scale transform.
//  Matrix4 matrixScale(Matrix4 matrix, double scale) {
//    if (widget.disableScale || scale == 1) {
//      return matrix;
//    }
//    assert(scale != 0);
//
//    final currentScale = _transform.getMaxScaleOnAxis();
//    final totalScale = currentScale * scale;
//    final clampedTotalScale = totalScale.clamp(widget.minScale, widget.maxScale) as double;
//    final clampedScale = clampedTotalScale / currentScale;
//    return matrix..scale(clampedScale);
//  }
//
//  Matrix4 matrixRotate(Matrix4 matrix, double rotation, Offset focalPoint) {
//    if (widget.disableRotation || rotation == 0) {
//      return matrix;
//    }
//    final focalPointScene = fromViewport(focalPoint, transform: matrix);
//    return matrix
//      ..translate(focalPointScene.dx, focalPointScene.dy)
//      ..rotateZ(-rotation)
//      ..translate(-focalPointScene.dx, -focalPointScene.dy);
//  }
//
//// Handle the start of a gesture of _GestureType.
//  void _onScaleStart(ScaleStartDetails details) {
//    _handledChangePage = false;
//    if (widget.onScaleStart != null) {
//      widget.onScaleStart(details);
//    }
//
//    if (_controller.isAnimating) {
//      _controller.stop();
//      _controller.reset();
//      _animation?.removeListener(_onAnimate);
//      _animation = null;
//    }
//    if (_controllerReset.isAnimating) {
//      _animateResetStop();
//    }
//
//    gestureType = null;
//    setState(() {
//      _scaleStart = _transform.getMaxScaleOnAxis();
//      _translateFromScene = fromViewport(details.focalPoint);
//      _rotationStart = _currentRotation;
//    });
//  }
//
//// Handle an update to an ongoing gesture of _GestureType.
//  void _onScaleUpdate(ScaleUpdateDetails details) {
//    var scale = _transform.getMaxScaleOnAxis();
//    if (widget.onScaleUpdate != null) {
//      widget.onScaleUpdate(ScaleUpdateDetails(
//        focalPoint: fromViewport(details.focalPoint),
//        scale: details.scale,
//        rotation: details.rotation,
//      ));
//    }
//    final focalPointScene = fromViewport(details.focalPoint);
//    if (gestureType == null) {
//      if ((details.scale - 1).abs() > details.rotation.abs()) {
//        gestureType = _GestureType.scale;
//      } else if (details.rotation != 0) {
//        gestureType = _GestureType.rotate;
//      } else {
//        gestureType = _GestureType.translate;
//      }
//    }
//
//    setState(() {
//      if (gestureType == _GestureType.scale && _scaleStart != null) {
//        final desiredScale = _scaleStart * details.scale;
//        final scaleChange = desiredScale / scale;
//        _transform = matrixScale(_transform, scaleChange);
//        scale = _transform.getMaxScaleOnAxis();
//        final focalPointSceneNext = fromViewport(details.focalPoint);
//        _transform = matrixTranslate(_transform, focalPointSceneNext - focalPointScene, boundaryRestrict: false);
//      } else if (gestureType == _GestureType.rotate && details.rotation != 0) {
//        final desiredRotation = _rotationStart + details.rotation;
//        _transform = matrixRotate(_transform, _currentRotation - desiredRotation, details.focalPoint);
//        _currentRotation = desiredRotation;
//      } else if (_translateFromScene != null && details.scale == 1) {
//        final translationChange = focalPointScene - _translateFromScene;
//        _transform = matrixTranslate(_transform, translationChange);
//        _translateFromScene = fromViewport(details.focalPoint);
//      }
//    });
//  }
//
//// Handle the end of a gesture of _GestureType.
//  void _onScaleEnd(ScaleEndDetails details) {
//    if (widget.onScaleEnd != null) {
//      widget.onScaleEnd(details);
//    }
//    if (_transform.getMaxScaleOnAxis() < 1) {
//      // 结束缩放动作，如果处于收缩状态，则恢复原状
//      animateResetInitialize(destination: _initialTransform);
//    } else {
//      Offset br = fromViewport(Offset(widget.size.width, widget.size.height)); // 右下角位置
//      Offset lt = fromViewport(Offset(0, 0)); // 座山叫位置
//      Matrix4 destination = _transform.clone();
//      if (br.dx > widget.size.width && br.dy > widget.size.height) {
//        // 右边、下面超出范围
//        destination.translate(br.dx - widget.size.width, br.dy - widget.size.height);
//      } else if (br.dx > widget.size.width) {
//        // 右边超出范围
//        destination.translate(br.dx - widget.size.width, 0.0);
//      } else if (br.dy > widget.size.height) {
//        // 下边超出范围
//        destination.translate(0.0, br.dy - widget.size.height);
//      }
//      if (lt.dx < 0 && lt.dy < 0) {
//        // 左边、上边超出范围
//        destination.translate(lt.dx, lt.dy);
//      } else if (lt.dx < 0) {
//        // 左边超出范围
//        destination.translate(lt.dx, 0.0);
//      } else if (lt.dy < 0) {
//        // 上边超出范围
//        destination.translate(0.0, lt.dy);
//      }
//      animateResetInitialize(destination: destination, duration: 200);
//      _transform = destination;
//    }
//    setState(() {
//      _scaleStart = null;
//      _rotationStart = null;
//      _translateFromScene = null;
//    });
//
//    _animation?.removeListener(_onAnimate);
//    _controller.reset();
//
//    // If the scale ended with velocity, animate inertial movement
////    final velocityTotal = details.velocity.pixelsPerSecond.dx.abs() + details.velocity.pixelsPerSecond.dy.abs();
////    if (velocityTotal == 0) {
////      return;
////    }else{
////      print('velocityTotal = $velocityTotal');
////    }
////    final translationVector = _transform.getTranslation();
////    final translation = Offset(translationVector.x, translationVector.y);
////    final inertialMotion = InertialMotion(details.velocity, translation);
////    _animation = Tween<Offset>(
////      begin: translation,
////      end: inertialMotion.finalPosition,
////    ).animate(_controller);
////    _controller.duration = Duration(milliseconds: inertialMotion.duration.toInt());
////    _animation.addListener(_onAnimate);
////    _controller.fling();
//  }
//
//// Handle inertia drag animation.
//  void _onAnimate() {
//    setState(() {
//      final translationVector = _transform.getTranslation();
//      final translation = Offset(translationVector.x, translationVector.y);
//      final translationScene = fromViewport(translation);
//      final animationScene = fromViewport(_animation.value);
//      final translationChangeScene = animationScene - translationScene;
//      _transform = matrixTranslate(_transform, translationChangeScene);
//    });
//    if (!_controller.isAnimating) {
//      _animation?.removeListener(_onAnimate);
//      _animation = null;
//      _controller.reset();
//    }
//  }
//
//// Handle reset to home transform animation.
//  void _onAnimateReset() {
//    setState(() {
//      _transform = _animationReset.value;
//    });
//    if (!_controllerReset.isAnimating) {
//      _animationReset?.removeListener(_onAnimateReset);
//      _animationReset = null;
//      _controllerReset.reset();
//    }
//  }
//
//// Initialize the reset to home transform animation.
//  void animateResetInitialize({Matrix4 destination, int duration = 200}) {
//    _controllerReset.reset();
//    _animationReset = Matrix4Tween(
//      begin: _transform,
//      end: destination ?? _initialTransform,
//    ).animate(_controllerReset);
//    _controllerReset.duration = Duration(milliseconds: duration);
//    _animationReset.addListener(_onAnimateReset);
//    _controllerReset.forward();
//  }
//
//// Stop a running reset to home transform animation.
//  void _animateResetStop() {
//    _controllerReset.stop();
//    _animationReset?.removeListener(_onAnimateReset);
//    _animationReset = null;
//    _controllerReset.reset();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    _controllerReset.dispose();
//    super.dispose();
//  }
//}
//
//// END
//
//@immutable
//class InertialMotion {
//  const InertialMotion(this._initialVelocity, this._initialPosition);
//
//  static const double _kFrictionalAcceleration = 0.01; // How quickly to stop
//  final Velocity _initialVelocity;
//  final Offset _initialPosition;
//
//  // The position when the motion stops.
//  Offset get finalPosition {
//    return _getPositionAt(Duration(milliseconds: duration.toInt()));
//  }
//
//  // The total time that the animation takes start to stop in milliseconds.
//  double get duration {
//    return (_initialVelocity.pixelsPerSecond.dx / 1000 / _acceleration.x).abs();
//  }
//
//  // The acceleration opposing the initial velocity in x and y components.
//  Vector2 get _acceleration {
//    // TODO(justinmc): Find actual velocity instead of summing?
//    final velocityTotal = _initialVelocity.pixelsPerSecond.dx.abs() + _initialVelocity.pixelsPerSecond.dy.abs();
//    final vRatioX = _initialVelocity.pixelsPerSecond.dx / velocityTotal;
//    final vRatioY = _initialVelocity.pixelsPerSecond.dy / velocityTotal;
//    return Vector2(
//      _kFrictionalAcceleration * vRatioX,
//      _kFrictionalAcceleration * vRatioY,
//    );
//  }
//
//  // The position at a given time.
//  Offset _getPositionAt(Duration time) {
//    final xf = _getPosition(
//      r0: _initialPosition.dx,
//      v0: _initialVelocity.pixelsPerSecond.dx / 1000,
//      t: time.inMilliseconds,
//      a: _acceleration.x,
//    );
//    final yf = _getPosition(
//      r0: _initialPosition.dy,
//      v0: _initialVelocity.pixelsPerSecond.dy / 1000,
//      t: time.inMilliseconds,
//      a: _acceleration.y,
//    );
//    return Offset(xf, yf);
//  }
//
//  // Solve the equation of motion to find the position at a given point in time
//  // in one dimension.
//  double _getPosition({double r0, double v0, int t, double a}) {
//    // Stop movement when it would otherwise reverse direction.
//    final stopTime = (v0 / a).abs();
//    if (t > stopTime) {
//      t = stopTime.toInt();
//    }
//
//    return r0 + v0 * t + 0.5 * a * pow(t, 2);
//  }
//}
