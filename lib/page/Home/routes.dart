import 'package:flutter/cupertino.dart';
import 'package:miz_bazi/page/Home/webPage/homeWeb.dart';
import 'package:miz_bazi/page/Home/webPage/mainGamePage.dart';
import '../../core/event.dart';
import '../Menu/mainMenu.dart';
import 'constText.dart';

enum RouteType {
  empty,
  home,
  mainGame,
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
    RouteType.home => _mainGameNAme,
    RouteType.mainGame => _mainGameNAme,
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

    return switch (routeType){
      RouteType.empty => Container(width: 0,height: 0,),
      RouteType.home => HomeWeb(),
      RouteType.mainGame => MainGameWeb(link:mainGameWebLink!,),
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
