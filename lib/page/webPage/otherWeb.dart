import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/event.dart';
import '../../core/appSettings.dart';
import '../../core/webPropertis.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';

import '../Home/routes.dart';

class OtherWeb extends StatefulWidget {

  @override
  State<OtherWeb> createState() => _State();
}

class _State extends State<OtherWeb> {

  InAppWebViewController? _webViewController;

  String get _url {
    return switch (Routes.routeType){
      RouteType.friend => '${AppStrings.localHost}/Frind.html',
      RouteType.group => '${AppStrings.localHost}/Group.html',
      RouteType.room => '${AppStrings.localHost}/Room.html',
      _ => '',
    };
  }

  @override
  void initState() {
    super.initState();
    streamMainBar.add(MainBarType.empty);
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BaseWeb(
        url: _url,
        script: WebPropertis.apiProperty,
        onWebViewCreated:(c)=>javaScriptHandler(c)
      );
  }

  void javaScriptHandler(InAppWebViewController c) {
    _webViewController = c;
    _webViewController?.addJavaScriptHandler(
        handlerName: "f_urlBack",
        callback: (args) {
          streamRoutes.add(ChengStateWeb(RouteType.home));
        });
  }

}
