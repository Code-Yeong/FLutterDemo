import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class CustomPageView extends StatefulWidget {
  CustomPageView({
    Key key,
    this.threshold = 0.9,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.onPageBeginChange,
    List<Widget> children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(children),
        super(key: key);

  CustomPageView.builder({
    Key key,
    this.threshold = 0.9,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.onPageBeginChange,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
        super(key: key);

  CustomPageView.custom({
    Key key,
    this.threshold = 0.9,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.onPageBeginChange,
    @required this.childrenDelegate,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(childrenDelegate != null),
        controller = controller ?? _defaultPageController,
        super(key: key);

  final double threshold; //新增字段，表示新页面可见部分百分比阈值，达到这个阈值则执行翻页回调(0.5 <= threshold <= 1.0)
  final Axis scrollDirection;
  final bool reverse;
  final PageController controller;
  final ScrollPhysics physics;
  final bool pageSnapping;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onPageBeginChange;
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
          final double rawPage = metrics.page;
          double fractional = rawPage - rawPage.truncate();
          if (widget.onPageBeginChange != null) {
            if ((fractional - 0.5).abs() > (widget.threshold - 0.5)) {
              //向左滑(或者右滑)[1-widget.threshold%]触发翻页逻辑
              if ((fractional - 0.5).abs() > (widget.threshold - 0.5)) {
                int currentPage = metrics.page.round();
                if (currentPage == _lastReportedPage) {
                  widget.onPageBeginChange(currentPage);
                }
              }
            }
          }
          if (widget.onPageChanged != null) {
            //向左滑(或者右滑)[widget.threshold%]触发翻页逻辑
            if ((fractional - 0.5).abs() > (widget.threshold - 0.5)) {
              int currentPage = metrics.page.round();
              if (currentPage != _lastReportedPage) {
                _lastReportedPage = currentPage;
                widget.onPageChanged(currentPage);
              }
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
