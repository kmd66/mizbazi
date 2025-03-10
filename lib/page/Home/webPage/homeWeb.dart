import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:iconsax/iconsax.dart';
import 'package:miz_bazi/Widgets/baseWeb.dart';
import 'package:miz_bazi/Widgets/showObj.dart';
import 'package:miz_bazi/core/appColor.dart';
import 'package:miz_bazi/core/event.dart';

import '../../../Widgets/btns.dart';
import '../../../core/appSettings.dart';
import '../routes.dart';

class HomeWeb extends StatefulWidget {
  @override
  State<HomeWeb> createState() => _State();
}

class _State extends State<HomeWeb> {

  late InAppWebViewController _webViewController;// webViewController.clearCache(); _webViewController?.clearHistory();

  bool isExitBtn = true;
  String get _urlHome => AppStrings.apiHost + 'pages/Home';
  String get _urlMain => AppStrings.apiHost + 'pages/Main';

  @override
  void initState() {
    streamMainBar.add(MainBarType.appBar);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _webViewController.dispose();
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
          }
      ),
      exitBtn()

    ]);
  }
  Widget exitBtn() {
    return ShowObj(obj:
    Positioned (
        bottom: 15,
        left: 15,
        child: CircleBtn(
          icon: Iconsax.logout,
          color:BaseColor,
          onPressed: (){
            // exit(0);
          },
        )
    ),
        isShow: isExitBtn
    );
  }

  void javaScriptHandler() {

    _webViewController.addJavaScriptHandler(
        handlerName: "onUrlLink",
        callback: (args) {
          setState(()=>isExitBtn = false);
          streamMainBar.add(MainBarType.all);
          var link = args[0].toString();
          Routes.mainGameWebLink= link;
          _webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(_urlMain+link)));
          // streamRoutes.add(ChengStateWeb(RouteType.mainGame, mainGameWebLink : link));
        });

    _webViewController.addJavaScriptHandler(
        handlerName: "fUrlBack",
        callback: (args) {
          setState(()=>isExitBtn = true);
          streamMainBar.add(MainBarType.appBar);
          Routes.mainGameWebLink= null;
          _webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(_urlHome)));
        });
  }
}
