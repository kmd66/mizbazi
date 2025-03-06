import 'dart:async';
import 'package:flutter/material.dart';

import '../core/appText.dart';
import '../core/event.dart';

class AppLoad extends StatefulWidget {
  @override
  _LoadinWidget createState() => _LoadinWidget();
}

class _LoadinWidget extends State<AppLoad> {
  String? _text ;

  @override
  void initState() {
    initStream();
    super.initState();
  }

  void  initStream(){
    if(streamLoad.hasListener == true)
      streamLoad.close();
    streamLoad = StreamController<String?>();
    streamLoad.stream.listen((value){
      _text = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return  _text != null?
    Positioned(
      top:  0,
      left: 0,
      right: 0,
      bottom: 0,
      child:Material(
          type: MaterialType.transparency,
          child:
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(125,0,0,0),
            ),
            child: Center(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                AppText(_text!),
              ],
            )
            ) ,
          )
      ),
    ):
    Container(width: 0, height: 0,);
  }

  @override
  void dispose() {
    super.dispose();
  }
}