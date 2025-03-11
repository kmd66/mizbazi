import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/Widgets/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../../../core/appSettings.dart';
import '../routes.dart';

class MainGameWeb extends StatefulWidget {
  const MainGameWeb({super.key, required this.link});
  final String link;

  @override
  State<MainGameWeb> createState() => _State();
}

class _State extends State<MainGameWeb> {

  late InAppWebViewController _webViewController;

  String get _url => AppStrings.apiHost + 'pages/Main' + widget.link;

  @override
  void initState() {
    streamMainBar.add(MainBarType.all);
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
          url: _url,
          onWebViewCreated:(c)
          {
            _webViewController = c;
            javaScriptHandler();
          }
      ),
    ]);
  }

  void javaScriptHandler() {
    _webViewController.addJavaScriptHandler(
        handlerName: "fUrlBack",
        callback: (args) {
          streamRoutes.add(ChengStateWeb(RouteType.home));
        });
  }
}
