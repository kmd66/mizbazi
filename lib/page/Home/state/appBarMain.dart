import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:miz_bazi/core/appText.dart';
import 'package:miz_bazi/page/Home/routes.dart';

import '../../../Widgets/Icon.dart';
import '../../../core/appColor.dart';
import '../../../core/event.dart';

class AppBarMain extends StatefulWidget implements PreferredSizeWidget {
  AppBarMain({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  _state createState() => _state();
}

class _state extends State<AppBarMain> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: BaseColor,
        shadowColor:BtnShadowColor(),
        title: AppText(Routes.routeName,),
        leading: Container(
          margin: const EdgeInsets.only(top: 0, right: 10.0, bottom: 0, left: 10.0),
          child:
          IconButton(
            onPressed: ()=> streamDialogRoutes.add(DialogRouteType.mainMenu),
            icon: AppIcon(Iconsax.menu_1),
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()=>streamMainBar.add(MainBarType.appBar),
            icon: AppIcon(Iconsax.notification),
          ),
        ]
    );
  }

}

