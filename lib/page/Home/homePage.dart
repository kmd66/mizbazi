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

  late AppBarMain _appBar;
  Widget get _body => AppBody();
  Widget get _navigationBar => AppNavigationBar();

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
    _appBar = AppBarMain();
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: BackgroundColor,
        ),
        Scaffold(
          appBar:barType == MainBarType.all || barType == MainBarType.appBar? _appBar:null,
          body: _body,
          bottomNavigationBar:barType == MainBarType.all || barType == MainBarType.navBar?_navigationBar:null,
        ),
        AppLoad(),
        MessageApp(),
        AppDialog()
      ],
    );
  }
}
