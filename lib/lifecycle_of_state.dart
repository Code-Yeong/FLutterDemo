import 'package:flutter/material.dart';

class TELifeCycleOfState extends StatefulWidget {
  @override
  State createState() {
    print("parent createState");
    return _TELifeCycleOfState();
  }

  @override
  StatefulElement createElement() {
    print("parent createElement");
    return StatefulElement(this);
  }
}

class _TELifeCycleOfState extends State<TELifeCycleOfState> {
  @override
  void initState() {
    super.initState();
    print("parent initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("parent didChangeDependencies");
  }

  num count = 0;

  @override
  Widget build(BuildContext context) {
    print("parent build");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Test lifeCycle"),
      ),
      body: Container(
        child: Center(
//          child: Text('$count'),
          child: TETextWidget(
            count: count,
          ),
        ),
      ),
      floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              ++count;
            });
          }),
    );
  }

  @override
  void dispose() {
    print("parent dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("parent deactivate");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("parent reassemble");
  }

  @override
  void didUpdateWidget(TELifeCycleOfState oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("parent didUpdateWidget");
  }
}

class TETextWidget extends StatefulWidget {
  TETextWidget({this.count});
  final num count;
  @override
  State createState() {
    return _TETextWidget();
  }

  @override
  StatefulElement createElement() {
    print("child createElement");
    return StatefulElement(this);
  }
}

class _TETextWidget extends State<TETextWidget> {
  @override
  void initState() {
    super.initState();
    print("child initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("child didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("child build");
    return Text('${widget.count}');
  }

  @override
  void dispose() {
    print("child dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("child deactivate");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("child reassemble");
  }

  @override
  void didUpdateWidget(TETextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("child didUpdateWidget");
  }
}
