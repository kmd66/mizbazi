import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/appText.dart';
import '../../../core/appColor.dart';
import '../../../core/appSettings.dart';

class HomeWeb extends StatefulWidget {
  @override
  State<HomeWeb> createState() => _State();
}

class _State extends State<HomeWeb> {

  late InAppWebViewController _webViewController;// webViewController.clearCache(); _webViewController?.clearHistory();

  String get _url => 'https://localhost:7230/pages/Home'; //AppStrings.apiHost + 'pages/Home';

  @override
  void initState() {
    print(_url);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _view(context)
    ],);
  }
  Widget _view(BuildContext context) {
    return InAppWebView(

      onConsoleMessage: (controller, consoleMessage) {
        print("-------------------CONSOLE MESSAGE: " + consoleMessage.message);
      },
      onPermissionRequest: (controller, request) async {
        print('-------------------request: $request');
        return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT
        );
      },
      initialSettings: InAppWebViewSettings(
        cacheEnabled: true, // فعال‌سازی کش
        mediaPlaybackRequiresUserGesture: false,
        // فعال کردن JavaScript
        javaScriptEnabled: true,
        // اجازه پخش رسانه درون‌خطی (برای iOS)
        allowsInlineMediaPlayback: true,

        // تنظیمات مربوط به دسترسی به دوربین و میکروفون
        iframeAllow: "camera; microphone",

        // تنظیمات مربوط به رابط کاربری
        // transparentBackground: true,
        disableContextMenu: false,

        // تنظیمات مربوط به امنیت
        // safeBrowsingEnabled: true,
      ),

      initialUrlRequest: URLRequest(url: WebUri(_url)),
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
      },
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onLoadStart: (controller, url) {
        print('Page started loading: $url');
      },
      onLoadStop: (controller, url) async {
        print('Page finished loading: $url');
      },
    );
  }
}
