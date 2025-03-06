import 'dart:async';

import '../model/Message.dart';

late StreamController<ChengState> chengStateMain;
StreamController<String?> streamLoad = StreamController<String?>();
StreamController<Message> streamMessage = StreamController<Message>();

enum StateType {
  reconnect,
  splash,
  login,
  register,
  home,
  empty,
}

class ChengState {
  ChengState(this.type, { this.msg = ""});
  final StateType type;
  final String msg;
}