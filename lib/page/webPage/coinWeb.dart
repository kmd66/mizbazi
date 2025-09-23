import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/event.dart';
import '../../core/appSettings.dart';
import '../../core/webPropertis.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';

class CoinWeb extends StatefulWidget {

  @override
  State<CoinWeb> createState() => _State();
}

class _State extends State<CoinWeb> {

  InAppWebViewController? _webViewController;
  String get _url => '${AppStrings.localHost}/WheelFortune.html';

  @override
  void initState() {
    super.initState();
    streamMainBar.add(MainBarType.all);
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BaseWeb(
          url: _url,
          script:WebPropertis.apiProperty,
          onWebViewCreated:(c)
          {
            _webViewController = c;
            javaScriptHandler();
          }
      );
  }

  void javaScriptHandler() {
  }

}
