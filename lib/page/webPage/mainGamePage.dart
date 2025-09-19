import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../../core/appSettings.dart';
import '../Home/routes.dart';

class MainGameWeb extends StatefulWidget {
  const MainGameWeb({super.key, required this.link});
  final String link;

  @override
  State<MainGameWeb> createState() => _State();
}

class _State extends State<MainGameWeb> {

  late InAppWebViewController _webViewController;

  String get _url => '${AppStrings.localHost}Main${widget.link}.html';

  @override
  void initState() {
    streamMainBar.add(MainBarType.navBar);
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
          onWebViewCreated:(c)=>javaScriptHandler(c)
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

    _webViewController.addJavaScriptHandler(
        handlerName: "f_initGameReceive",
        callback: (args) {
          var link = args[0].toString();

          if(link.contains('localhost:')){
            link = link.replaceAll('localhost:', '10.0.3.2:');
          }
          streamRoutes.add(ChengStateWeb(RouteType.game, link : link));
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "f_restartGameReceive",
        callback: (args) {
        });
  }

}
