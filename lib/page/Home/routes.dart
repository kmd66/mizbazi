import 'package:flutter/cupertino.dart';
import '../../core/event.dart';
import '../Menu/mainMenu.dart';
import '../testKhande/testKhandePage.dart';
import '../webPage/coinWeb.dart';
import '../webPage/helpWeb.dart';
import '../webPage/homeWeb.dart';
import '../webPage/mainGamePage.dart';
import 'constText.dart';

enum RouteType {
  empty,
  home,
  gameMain,
  gameHelp,
  testKhande,
  coinWeb,
}
class Routes {
  static RouteType routeType = RouteType.empty;

  static String? _mainGameWebLink;
  static String? get mainGameWebLink=>_mainGameWebLink;
  static set mainGameWebLink (String? value) {
    if(value !=_mainGameNAme){
      _mainGameWebLink = value;
      streamAppBar.add(true);
    }
  }

  static String get routeName => switch (routeType){
    RouteType.empty => ' ',
    RouteType.home => HOME_PAGE,
    RouteType.gameHelp => HELP,
    RouteType.gameMain => _mainGameNAme,
    RouteType.testKhande => TESTLABKHAND,
    RouteType.coinWeb => COIN,
  };

  static String get _mainGameNAme => switch (Routes.mainGameWebLink){
    '25' => NABARD_KHANDE,
    '45' => RANG_RAZE,
    '68' => AFSON_VAJEH,
    '89' => MAFIA,
      _ => HOME_PAGE
  };

  static Widget change(ChengStateWeb model) {
    routeType = model.type;
    mainGameWebLink = model.mainGameWebLink;
    return switch (routeType){
      RouteType.empty => Container(width: 0,height: 0,),
      RouteType.home => HomeWeb(),
      RouteType.gameMain => MainGameWeb(link:mainGameWebLink!,),
      RouteType.gameHelp => HelpWeb(link:mainGameWebLink!,),
      RouteType.testKhande => TestKhandePage(),
      RouteType.coinWeb => CoinWeb(),
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
