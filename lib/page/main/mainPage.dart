import 'package:miz_bazi/page/main/register.dart';

import '../../Widgets/Load.dart';
import '../../Widgets/Msg.dart';
import '../../core/appColor.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:miz_bazi/page/main/reconnect.dart';
import 'package:miz_bazi/page/main/splashPage.dart';
import '../../core/appInfo.dart';
import '../../core/appSettings.dart';
import '../../core/event.dart';
import '../Home/homePage.dart';
import 'login.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _State();
}

class _State extends State<MainPage> {

  Widget _state =  splashPage();
  
  StateType stateType = StateType.splash;

  @override
  void initState() {
    _SystemMode();
    _setDeviceId();
    chengStateMain = StreamController<ChengState>();
    chengStateMain.stream.listen((value) {
      setState(() {
        _state = switch (value.type){
          StateType.empty => Container(width: 0,height: 0,),
          StateType.splash =>splashPage(),
          StateType.home =>HomePage(),
          StateType.login => Login(),
          StateType.register => Register(),
          StateType.reconnect => Reconnect(value.msg),
        };
      });
    });

    super.initState();
  }

  void _SystemMode(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _setDeviceId() async{
    var devInfo = DevInfo();
    await devInfo.initPlatformState();
    var json = jsonEncode(devInfo.deviceData);
    AppStrings.deviceId = md5.convert(utf8.encode(json)).toString();
  }

  @override
  void dispose() {
    chengStateMain.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(stateType == StateType.home)
      return _state;

    return
      Scaffold(
          body:
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: BackgroundColor,
            ),
            Center( child: Image.asset('assets/img/splash.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),),
            _state,
            AppLoad(),
            MessageApp()
          ],)
      );
  }
}
