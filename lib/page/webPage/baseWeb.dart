import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BaseWeb extends StatefulWidget {
  BaseWeb({required this.url, this.onWebViewCreated, this.onLoadStop});
  final String url;
  final Function(InAppWebViewController)? onWebViewCreated;
  final Function()? onLoadStop;

  @override
  _state createState() => _state();
}

class _state extends State<BaseWeb>{
  // late InAppWebViewController _webViewController;
  bool isLoading = true;
  bool hasError = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // _view(),
      hasError?_error(): _view(),
      if (isLoading) _load(),
    ]);
  }

  Widget _load() {
    return  Center(child: CircularProgressIndicator());
  }

  Widget _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("خطا در اتصال به اینترنت", style: TextStyle(fontSize: 18)),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                hasError = false;
              });
            },
            child: Text("تلاش مجدد"),
          ),
        ],
      ),
    );
  }

  Widget _view() {
    return InAppWebView(
      // key: ValueKey(DateTime.now().toString()),
      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      initialSettings:_WebSettings(),

      onWebViewCreated: (controller) {
        // _webViewController=controller;
        if(widget.onWebViewCreated != null){
          widget.onWebViewCreated!(controller);
        }
      },

      onConsoleMessage: (controller, consoleMessage) {
      },

      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
      },

      onLoadStart: (controller, url) {
        setState(() {
          isLoading = true;
          hasError = false;
        });
      },
      onLoadStop: (controller, url) {
        setState(() {
          isLoading = false;
          if(!hasError && widget.onLoadStop != null){
            widget.onLoadStop!();
          }
        });
      },
      onReceivedError: (controller, request, error) {
        if(error.type.toString().contains('CONNECT')) {
          setState(() {
          hasError = true;
          isLoading = false;
        });
        }
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

}