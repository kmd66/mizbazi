import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/event.dart';
import '../../core/appSettings.dart';
import '../../services/localServer.dart';

class CoinWeb extends StatefulWidget {

  @override
  State<CoinWeb> createState() => _State();
}

class _State extends State<CoinWeb> {

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      // key: ValueKey(DateTime.now().toString()), 127.0.0.1 یا localhost
      initialUrlRequest: URLRequest(url: WebUri('http://127.0.0.1:8014/Main89.html')),
      initialSettings:_WebSettings(),
      onWebViewCreated: (controller) {
      },
      onConsoleMessage: (controller, consoleMessage) {
      },

      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
      },

      onLoadStart: (controller, url) {
      },
      onLoadStop: (controller, url) {
      },
      onReceivedHttpError: (controller, request, errorResponse) {
      },
      onReceivedError: (controller, request, error) {
      },

    );
  }

  InAppWebViewSettings _WebSettings() {
    return InAppWebViewSettings(
      cacheEnabled: false, // فعال‌سازی کش
      // cacheMode: CacheMode.LOAD_CACHE_ELSE_NETWORK,
      mediaPlaybackRequiresUserGesture: false,
      // فعال کردن JavaScript
      javaScriptEnabled: true,
      // اجازه پخش رسانه درون‌خطی (برای iOS)
      allowsInlineMediaPlayback: true,
      // تنظیمات مربوط به دسترسی به دوربین و میکروفون
      iframeAllow: "camera; microphone",

      // تنظیمات مربوط به رابط کاربری
      transparentBackground: true,
      disableContextMenu: false,
      // تنظیمات مربوط به امنیت
      // safeBrowsingEnabled: true,

    );
  }
  void javaScriptHandler(InAppWebViewController c) {

  }

}
