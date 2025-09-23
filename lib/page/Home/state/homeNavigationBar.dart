import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Widgets/btns.dart';
import '../../../core/appColor.dart';
import '../../../core/event.dart';
import '../../../services/downloadAssets.dart';
import '../constText.dart';
import '../routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Stack(children: [
      coinBtn(),
      exitBtn(),
      otherBtn()
    ],);
  }
  Widget exitBtn() {
    return
      Positioned (
          bottom: 15,
          left: 15,
          child: CircleBtn(
              text: EXIT,
              icon: Iconsax.logout,
            onPress: ()=>update()
            //onPress: ()=>exit(0)
          )
      );
  }

  Widget coinBtn() {
    return
      Positioned (
          bottom: 15,
          right: 15,
          child: CircleBtn(
            text: "0 \$",
            icon: Iconsax.bitcoin_refresh,
            color:BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.coinWeb)),
          )
      );
  }
  Widget otherBtn() {
    return
      Positioned (
          top: 15,
          right: 15,
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 14),child: CircleBtn(
              size: 45,
              color: BackgroundColor,
              icon: Iconsax.heart,
              onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.friend)),
            )),
            Padding(padding: const EdgeInsets.symmetric(vertical: 14),child: CircleBtn(
              size: 45,
              icon: Iconsax.people,

              color: BackgroundColor,
              onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.group)),
            )),
            Padding(padding: const EdgeInsets.symmetric(vertical: 14),child: CircleBtn(
              size: 45,
              color: BackgroundColor,
              icon: Iconsax.bookmark,
              onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.room)),
            )),
          ])
      );
  }

  update() async{
    SharedPreferences local = await SharedPreferences.getInstance();
    if(local.containsKey('appVersion')){
      await local.remove("appVersion");
    }
    print('----------------DownloadAssets start---------------------');
    var t = DownloadAssets();
    await t.CheckUpdate();
    print('----------------DownloadAssets end---------------------');

  }
}