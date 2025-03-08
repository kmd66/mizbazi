import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/event.dart';
import '../routes.dart';

class AppDialog extends StatefulWidget {
  @override
  _state createState() => _state();
}

class _state extends State<AppDialog> {

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
    _obj = DialogRoutes.change(DialogRouteType.empty);
    if(streamDialogRoutes.hasListener == true) {
      streamDialogRoutes.close();
    }
    streamDialogRoutes = StreamController<DialogRouteType>();
    streamDialogRoutes.stream.listen((value){
      if(DialogRoutes.dialogType != value){
        setState(() {
          _obj = DialogRoutes.change(value);
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) => _obj;
}