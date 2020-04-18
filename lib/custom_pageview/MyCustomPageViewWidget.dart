import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class CustomPageView extends StatefulWidget {
  CustomPageView({
    Key key,
    this.autoScrollPage = false,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(children),
        super(key: key);

  CustomPageView.builder({
    Key key,
    this.autoScrollPage = false,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
        super(key: key);

  CustomPageView.custom({
    Key key,
    this.autoScrollPage = false,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required this.childrenDelegate,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(childrenDelegate != null),
        controller = controller ?? _defaultPageController,
        super(key: key);

  final Axis scrollDirection;
  final bool reverse;
  final PageController controller;
  final ScrollPhysics physics;
  final bool pageSnapping;
  final bool autoScrollPage; //滑动超过一半时自动滑完下一半
  final ValueChanged<int> onPageChanged;
  final SliverChildDelegate childrenDelegate;
  final DragStartBehavior dragStartBehavior;

  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<CustomPageView> {
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection = textDirectionToAxisDirection(textDirection);
        return widget.reverse ? flipAxisDirection(axisDirection) : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = widget.pageSnapping ? _kPagePhysics.applyTo(widget.physics) : widget.physics;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 && notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics;
          final int newPage = metrics.page.round();
          if (newPage != _lastReportedPage) {
            _lastReportedPage = newPage;
            if (widget.autoScrollPage) {
              widget.controller.animateToPage(newPage, duration: Duration(milliseconds: 100), curve: Curves.ease).then((value) {
                if (widget.onPageChanged != null) {
                  widget.onPageChanged(newPage);
                }
              });
            } else {
              widget.onPageChanged(newPage);
            }
          }
        }
        return false;
      },
      child: Scrollable(
        dragStartBehavior: widget.dragStartBehavior,
        axisDirection: axisDirection,
        controller: widget.controller,
        physics: physics,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            cacheExtent: 0.0,
            axisDirection: axisDirection,
            offset: position,
            slivers: <Widget>[
              SliverFillViewport(
                viewportFraction: widget.controller.viewportFraction,
                delegate: widget.childrenDelegate,
              ),
            ],
          );
        },
      ),
    );
  }
}
