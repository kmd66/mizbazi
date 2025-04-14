import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miz_bazi/core/event.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import '../../core/appSettings.dart';

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
    if(decryptedHtml != null)
      return;
    var _path = path.join(AppStrings.downloadPath!, 'WheelFortune.html');
    final file = File(_path);
    String content = await file.readAsString();
    setState(() {
      decryptedHtml =content;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      decryptedHtml == null
          ? const Center(child: CircularProgressIndicator())
          : InAppWebView(
          initialData: InAppWebViewInitialData(
          data: decryptedHtml!,
          encoding: "utf-8",
          mimeType: "text/html",
        ),
      )
    ]);
  }

  void javaScriptHandler(InAppWebViewController c) {

  }

}
