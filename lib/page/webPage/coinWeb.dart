import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/event.dart';
import '../../core/appSettings.dart';
import '../../services/localServer.dart';
import '../../core/webPropertis.dart';
import 'package:miz_bazi/page/webPage/baseWeb.dart';

class CoinWeb extends StatefulWidget {

  @override
  State<CoinWeb> createState() => _State();
}

class _State extends State<CoinWeb> {

  late InAppWebViewController _webViewController;
  String get _url => '${AppStrings.localHost}/WheelFortune.html';
  String? decryptedHtml;

  @override
  void initState() {
    super.initState();
    streamMainBar.add(MainBarType.all);
    loadHtml();
  }
  Future loadHtml() async{
    final server = LocalServer();
    await server.start(folderPath: AppStrings.downloadPath!, port: 8014);
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
