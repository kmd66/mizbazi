import 'package:flutter/cupertino.dart';
import 'package:miz_bazi/page/Home/webPage/homeWeb.dart';
import '../Menu/mainMenu.dart';
import 'constText.dart';

enum RouteType {
  empty,
  home
}
class Routes {
  static RouteType routeType = RouteType.empty;

  static String get routeName => switch (routeType){
    RouteType.empty => ' ',
    RouteType.home => HOME_PAGE,
  };

  static Widget change(RouteType type) {
    routeType = type;
    return switch (type){
      RouteType.empty => Container(width: 0,height: 0,),
      RouteType.home => HomeWeb(),
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
