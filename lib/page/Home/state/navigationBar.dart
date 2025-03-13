import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Widgets/Icon.dart';
import '../../../Widgets/btns.dart';
import '../../../core/appColor.dart';
import '../../../core/event.dart';
import '../constText.dart';
import '../routes.dart';

class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget{
  AppNavigationBar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  List<Widget> setList() {
    return
      [
        CircleBtn(
            text: PROFILE,
            icon: Iconsax.user,
            color: BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.gameMain, mainGameWebLink : '89'))
        ),
        CircleBtn(
            text: '0 \$',
            icon: Iconsax.bitcoin_refresh,
            color: BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.coinWeb))
        ),
        homeContainer(),
        CircleBtn(
            text: HISTORY,
            icon: Iconsax.calendar_tick,
            color: BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.gameMain, mainGameWebLink : '25'))
        ),
        CircleBtn(
            text:GROUP,
            icon: Iconsax.people,
            color: BaseColor,
            onPress: ()=>streamRoutes.add(ChengStateWeb(RouteType.gameMain, mainGameWebLink : '45'))
        )
      ];
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
            children: setList(),
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
          onTap: ()=> streamRoutes.add(ChengStateWeb(RouteType.home)),
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
}