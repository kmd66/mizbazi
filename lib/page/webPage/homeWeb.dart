import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../../../core/appSettings.dart';
import '../Home/routes.dart';
import '../Home/state/homeNavigationBar.dart';

class HomeWeb extends StatefulWidget {
  @override
  State<HomeWeb> createState() => _State();
}

class _State extends State<HomeWeb> {

  late InAppWebViewController _webViewController;// webViewController.clearCache(); _webViewController?.clearHistory();

  bool isExitBtn = true;
  String get _urlHome => AppStrings.apiHost + 'pages/Home';

  @override
  void initState() {
    streamMainBar.add(MainBarType.appBar);
    super.initState();
  }

  @override
  void dispose() {
    // _webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BaseWeb(
          url: _urlHome,
          onWebViewCreated:(c)
          {
            _webViewController = c;
            javaScriptHandler();
          },
          onLoadStop:() async{
            var script = """
                function saveTokenToLocalStorage(deviceId, token) {
                    if (localStorage.getItem("publicDeviceId") != null) {
                        localStorage.removeItem("publicDeviceId");
                    }
                    if (localStorage.getItem("publicToken") != null) {
                        localStorage.removeItem("publicToken");
                    }
                    localStorage.setItem("publicDeviceId", deviceId);
                    localStorage.setItem("publicToken", token);
                    publicDeviceId = deviceId;
                    publicToken = token;
                }
                saveTokenToLocalStorage('${AppStrings.deviceId}', '${AppStrings.auth}');
""";
            await _webViewController.evaluateJavascript(source: script);

          }
      ),
      HomeNavigationBar()

    ]);
  }

  void javaScriptHandler() {

    _webViewController.addJavaScriptHandler(
        handlerName: "f_urlHelp",
        callback: (args) {
          var link = args[0].toString();
          streamRoutes.add(ChengStateWeb(RouteType.gameHelp, mainGameWebLink : link));
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "f_urlMain",
        callback: (args) {
          var link = args[0].toString();
          streamRoutes.add(ChengStateWeb(RouteType.gameMain, mainGameWebLink : link));
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "f_testKhande",
        callback: (args) {
          streamRoutes.add(ChengStateWeb(RouteType.testKhande));
        });
  }
}
