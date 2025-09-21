import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/webPropertis.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../Home/routes.dart';
import 'dart:convert';

class GameWeb extends StatefulWidget {
  const GameWeb({super.key, required this.link});
  final String link;

  @override
  State<GameWeb> createState() => _State();
}

class _State extends State<GameWeb> {

  late InAppWebViewController _webViewController;

  late String _url;

  @override
  void initState() {
    streamMainBar.add(MainBarType.navBar);
    final Map obj = json.decode(widget.link);
    _url = '${WebPropertis.url(obj['BaseUrl'])}/${obj['UserGameName']}?roomId=${obj['RoomId']}&userKey=${obj['Key']}&userId=${obj['Id']}';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BaseWeb(
        url: _url,
        script: WebPropertis.gameProperty(widget.link),
        onWebViewCreated:(c)=>javaScriptHandler(c),
      ),
    ]);
  }

  void javaScriptHandler(InAppWebViewController c) {
    _webViewController = c;
    _webViewController.addJavaScriptHandler(
        handlerName: "f_urlBack",
        callback: (args) {
          streamRoutes.add(ChengStateWeb(RouteType.home));
        });
  }

}
