import 'dart:async';

import '../model/Message.dart';
import '../page/Home/routes.dart';

late StreamController<ChengState> chengStateMain;

StreamController<String?> streamLoad = StreamController<String?>();
StreamController<Message> streamMessage = StreamController<Message>();

StreamController<MainBarType> streamMainBar = StreamController<MainBarType>();

StreamController<ChengStateWeb> streamRoutes = StreamController<ChengStateWeb>();
StreamController<DialogRouteType> streamDialogRoutes = StreamController<DialogRouteType>();
StreamController<bool> streamAppBar = StreamController<bool>();

enum StateType {
  reconnect,
  splash,
  login,
  register,
  home,
  empty,
}

enum MainBarType {
  empty,
  navBar,
  appBar,
  all
}

class ChengState {
  ChengState(this.type, { this.msg = ""});
  final StateType type;
  final String msg;
}
class ChengStateWeb {
  ChengStateWeb(this.type, { this.mainGameWebLink});
  final RouteType type;
  final String? mainGameWebLink;
}