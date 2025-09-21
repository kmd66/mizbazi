import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/appSettings.dart';
import '../../core/webPropertis.dart';
import '../Home/routes.dart';
import '../Home/state/homeNavigationBar.dart';

class HomeWeb extends StatefulWidget {
  @override
  State<HomeWeb> createState() => _State();
}

class _State extends State<HomeWeb> {

  late InAppWebViewController _webViewController;// webViewController.clearCache(); _webViewController?.clearHistory();

  bool isExitBtn = true;
  bool isPermission = false;
  String get _urlHome => '${AppStrings.localHost}/Home.html';

  @override
  void initState() {
    streamMainBar.add(MainBarType.appBar);
    super.initState();
    requestCameraAndMicPermissions();
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
          script:WebPropertis.apiProperty,
          onWebViewCreated:(c)
          {
            _webViewController = c;
            javaScriptHandler();
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
          streamRoutes.add(ChengStateWeb(RouteType.gameHelp, link : link));
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "f_urlMain",
        callback: (args) async {
          var link = args[0].toString();
          var p = await requestCameraAndMicPermissions();
          if(p){
            streamRoutes.add(ChengStateWeb(RouteType.gameMain, link : link));
          }
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "f_testKhande",
        callback: (args) {
          streamRoutes.add(ChengStateWeb(RouteType.game));
        });
  }


  Future<bool> requestCameraAndMicPermissions() async {
    if(isPermission) return true;
    var cameraStatus = await Permission.camera.status;
    var micStatus = await Permission.microphone.status;

    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
    }

    if (micStatus.isDenied) {
      micStatus = await Permission.microphone.request();
    }

    if (cameraStatus.isGranted && micStatus.isGranted) {
      isPermission = true;
      return true;
    } else {
      return false;
    }
  }
}
