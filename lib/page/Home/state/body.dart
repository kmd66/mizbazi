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
    _obj = Routes.change(ChengStateWeb(RouteType.home));

    if(streamRoutes.hasListener == true) {
      streamRoutes.close();
    }
    streamRoutes = StreamController<ChengStateWeb>();
    streamRoutes.stream.listen((value) async{
      if(Routes.routeType != value.type){
        setState(()=>_obj = Routes.change(ChengStateWeb(RouteType.empty)));
        await Future.delayed(Duration(milliseconds: 200));
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