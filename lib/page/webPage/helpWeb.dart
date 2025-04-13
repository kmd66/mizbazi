import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';
import 'package:miz_bazi/core/event.dart';
import '../../../core/appSettings.dart';

class HelpWeb extends StatefulWidget {
  const HelpWeb({super.key, required this.link});
  final String link;

  @override
  State<HelpWeb> createState() => _State();
}

class _State extends State<HelpWeb> {

  late InAppWebViewController _webViewController;

  String get _url => '${AppStrings.apiHost}pages/help?gameId=${widget.link}';

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
      )
    ]);
  }

  void javaScriptHandler(InAppWebViewController c) async {
    _webViewController = c;
    await _webViewController.evaluateJavascript(source: "publicToken = '${AppStrings.auth}'; publicDeviceId = '${AppStrings.deviceId}';");
  }
}
