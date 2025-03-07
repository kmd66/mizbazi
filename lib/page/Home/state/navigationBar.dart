import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:miz_bazi/core/appText.dart';

import '../../../Widgets/Icon.dart';
import '../../../core/appColor.dart';
import '../../../core/event.dart';
import '../constText.dart';

class AppNavigationBar extends StatefulWidget implements PreferredSizeWidget{
  AppNavigationBar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  _state createState() => _state();
}

class _state extends State<AppNavigationBar> {
  List<Widget> list = [];

  @override
  void initState() {
    setList();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  void setList() {
    list.add(selectContainer(
        title: PROFILE,
        icon: Iconsax.user,
        onPress: ()=>streamMainBar.add(MainBarType.navBar)
    ));
    list.add(selectContainer(
        title: '0 \$',
        icon: Iconsax.coin_15,
        onPress: ()=>streamMainBar.add(MainBarType.navBar)
    ));
    list.add( homeContainer());
    list.add(selectContainer(
        title: GARDONE,
        icon: Iconsax.bitcoin_refresh,
        onPress: ()=>streamMainBar.add(MainBarType.navBar)
    ));
    list.add(selectContainer(
        title:GROUP,
        icon: Iconsax.people,
        onPress: ()=>streamMainBar.add(MainBarType.navBar)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BackgroundColor,
      child:Container(
        constraints: BoxConstraints(minWidth: 320,),
        margin: const EdgeInsets.only(left : 14.0,bottom: 14.0,right: 14.0),
        decoration: BoxDecoration(
          color: BaseColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: list,
        ),
      )
    );
  }


  Widget homeContainer() {
    return  Stack(children: [
      Container(
        transform: Matrix4.translationValues(3.0, -0.0, 0.0),
        height: 38,
        width: 66,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
          color: BackgroundColor,
        ),
      ),
      InkWell(
          onTap: ()=>streamMainBar.add(MainBarType.all),
          child:Container(
            transform: Matrix4.translationValues(0.0, -25, 0.0),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(132, 142, 161, 1),
              // border: Border.all(width: 5, color:ObjectColor.baseBackground)
            ),
            child:
            Center(child: AppIcon(Iconsax.home,color: BackgroundColor,),),

          )
      )
    ]);
  }
  Widget selectContainer({required String title, required IconData icon, required VoidCallback onPress} ) {
    return
      Container(
          height: 60,
          child:InkWell(
            onTap: ()=>onPress(),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child:
                      AppIcon(icon)
                  ) ,
                  Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child:
                      Center(
                          child:
                          AppText(title,fontSize: 10,color: TextColor2,))
                  ),
                ]),
          )
      );
  }
}