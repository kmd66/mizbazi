import 'package:flutter/cupertino.dart';
import '../../core/event.dart';
import '../Menu/mainMenu.dart';
import '../testKhande/testKhandePage.dart';
import '../webPage/coinWeb.dart';
import '../webPage/gamePage.dart';
import '../webPage/helpWeb.dart';
import '../webPage/homeWeb.dart';
import '../webPage/mainGamePage.dart';
import '../webPage/otherWeb.dart';
import 'constText.dart';

enum RouteType {
  empty,
  home,
  game,
  gameMain,
  gameHelp,
  testKhande,
  coinWeb,

  friend,
  group,
  room
}
class Routes {
  static RouteType routeType = RouteType.empty;

  static String? _link;
  static String? get link=>_link;
  static set link (String? value) {
    if(value !=_mainGameNAme){
      _link = value;
      streamAppBar.add(true);
    }
  }

  static String get routeName => switch (routeType){
    RouteType.empty => ' ',
    RouteType.home => HOME_PAGE,
    RouteType.game => GAME,
    RouteType.gameHelp => HELP,
    RouteType.gameMain => _mainGameNAme,
    RouteType.testKhande => TESTLABKHAND,
    RouteType.coinWeb => COIN,
    RouteType.friend => FRIEND,
    RouteType.group => GROUP,
    RouteType.room => ROOM,
  };

  static String get _mainGameNAme => switch (Routes.link){
    '25' => NABARD_KHANDE,
    '45' => RANG_RAZE,
    '68' => AFSON_VAJEH,
    '89' => MAFIA,
      _ => HOME_PAGE
  };

  static Widget change(ChengStateWeb model) {
    routeType = model.type;
    link = model.link;
    return switch (routeType){
      RouteType.empty => Container(width: 0,height: 0,),
      RouteType.home => HomeWeb(),
      RouteType.game => GameWeb(link:link!,),
      RouteType.gameMain => MainGameWeb(link:link!,),
      RouteType.gameHelp => HelpWeb(link:link!,),
      RouteType.testKhande => TestKhandePage(),
      RouteType.coinWeb => CoinWeb(),

      RouteType.friend || RouteType.group || RouteType.room => OtherWeb(),
    };
  }
}

enum DialogRouteType {
  empty,
  mainMenu
}

class DialogRoutes {
  static DialogRouteType dialogType = DialogRouteType.empty;

  static Widget change(DialogRouteType type) {
    dialogType = type;
    return switch (type){
      DialogRouteType.empty => Container(width: 0,height: 0,),
      DialogRouteType.mainMenu => MainMenu(),
    };
  }
}
