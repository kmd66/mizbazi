import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/appColor.dart';
import '../../../core/event.dart';
import '../routes.dart';

class AppBody extends StatefulWidget {
  @override
  _state createState() => _state();
}

class _state extends State<AppBody> {

  late Widget _obj;

  @override
  void initState() {
    initStream();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initStream() async{
    _obj = Routes.change(RouteType.home);

    if(streamRoutes.hasListener == true) {
      streamRoutes.close();
    }
    streamRoutes = StreamController<RouteType>();
    streamRoutes.stream.listen((value){
      if(DialogRoutes.dialogType != value){
        setState(() {
          _obj = Routes.change(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: BackgroundColor,
        child: _obj,
  );
}