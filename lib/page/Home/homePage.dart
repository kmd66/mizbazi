import 'dart:async';
import 'package:flutter/material.dart';
import 'package:miz_bazi/page/Home/state/appBarMain.dart';
import 'package:miz_bazi/page/Home/state/body.dart';
import 'package:miz_bazi/page/Home/state/dialog.dart';
import 'package:miz_bazi/page/Home/state/navigationBar.dart';
import '../../Widgets/Load.dart';
import '../../Widgets/Msg.dart';
import '../../core/appColor.dart';
import '../../core/event.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {

  var barType = MainBarType.empty;

  PreferredSizeWidget? get _appBar =>
      barType == MainBarType.all ||
      barType == MainBarType.appBar ? AppBarMain() : null;
  Widget get _body => AppBody();
  PreferredSizeWidget? get _navigationBar =>
      barType == MainBarType.all ||
      barType == MainBarType.navBar ? AppNavigationBar() : null;

  @override
  void initState() {
    super.initState();
    initStream();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initStream() async{
    if(streamMainBar.hasListener == true) {
      streamMainBar.close();
    }

    streamMainBar = StreamController<MainBarType>();
    streamMainBar.stream.listen((value){
      setState(() {
        barType = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BackgroundColor,
        ),
        Scaffold(
          appBar:_appBar,
          body: _body,
          bottomNavigationBar:_navigationBar,
        ),
        AppLoad(),
        MessageApp(),
        AppDialog()
      ],
    );
  }
}
