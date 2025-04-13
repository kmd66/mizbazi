import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/appSettings.dart';
import '../../core/appText.dart';
import '../../core/event.dart';
import '../../services/UserService.dart';
import '../../services/pblService.dart';
import 'constText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashPage extends StatefulWidget {
  @override
  State<splashPage> createState() => _State();
}

class _State extends State<splashPage> {

  var userService = UserService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadAppStrings();
    });

  }

  void  loadAppStrings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await AppStrings.loadJson();
    setState(() {});
    checkHost();
  }

  Future<void> checkHost() async {

    await Future.delayed(const Duration(seconds: 2));
    var service = PblService();
    var model = await service.checkHost();
    if(!model.resultSuccess){
      chengStateMain.add(ChengState(StateType.reconnect, msg: '${model.resultCode} - ${model.resultMessage}'));
      return;
    }
    SharedPreferences local = await SharedPreferences.getInstance();

    if(local.containsKey('WebWersion')){
      await local.remove("WebWersion");
    }
    AppStrings.webWersion = model;


    checkLogin(local);
  }

  Future<void>  checkLogin(SharedPreferences local) async {
    if(!local.containsKey('auth')){
      chengStateMain.add(ChengState(StateType.login));
      return;
    }
    AppStrings.auth = await local.getString('auth');
    await userService.Get();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Stack(children: [

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: AppText(AppStrings.appName,fontSize:28),
          ),
        ),

        Center(child: AppText(AppStrings.appComment),),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: AppText(LOAD,fontSize:14),
          ),
        ),

      ],);
  }
}
