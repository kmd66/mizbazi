import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miz_bazi/core/appText.dart';

//ignore: must_be_immutable
class CounDown extends StatefulWidget {
  CounDown({required this.seconds,this.label = 'زمان باقی مانده'});

  int seconds;
  String label;

  late Timer _timer;
  late int _start;
  _state state = new _state();

  void reset() {
    _timer.cancel();
    start();
  }
  void start() {
    _start = seconds;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          state.setState(() {
            timer.cancel();
          });
        } else {
          state.setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  _state createState() {
    return this.state = new _state();
  }

}

class _state extends State<CounDown> {

  @override
  void initState() {
    super.initState();
    widget.start();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    //ignore: must_be_immutable
    widget._timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppText('${widget.label}  ${widget._start.toString()} ثانیه',);
  }
}