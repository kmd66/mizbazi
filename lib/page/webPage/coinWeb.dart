import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../../../core/appSettings.dart';

class CoinWeb extends StatefulWidget {

  @override
  State<CoinWeb> createState() => _State();
}

class _State extends State<CoinWeb> {

  String get _url => '${AppStrings.apiHost}home/WheelFortune';

  @override
  void initState() {
    streamMainBar.add(MainBarType.all);
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

  }

}
