import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Widgets/btns.dart';
import '../../../core/appColor.dart';
import '../../../core/event.dart';
import '../../../services/downloadAssests.dart';
import '../constText.dart';
import '../routes.dart';

class HomeNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Stack(children: [
      coinBtn(),
      exitBtn()
    ],);
  }
  Widget coinBtn() {
    return
      Positioned (
          bottom: 15,
          left: 15,
          child: CircleBtn(
            text: "0 \$",
            icon: Iconsax.bitcoin_refresh,
            color:BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.coinWeb)),
          )
      );
  }
  Widget exitBtn() {
    return
      Positioned (
          bottom: 100,
          left: 15,
          child: CircleBtn(
              text: EXIT,
              icon: Iconsax.logout,
            // onPress:exitBtn2
            onPress: ()=>exit(0)
          )
      );
  }
  void exitBtn2() async{
    // chengStateMain.add(ChengState(StateType.splash));
    print('----------------DownloadAssests start---------------------');
    var t = DownloadAssests();
    await t.CheckUpdate();
    print('----------------DownloadAssests end---------------------');
  }

}