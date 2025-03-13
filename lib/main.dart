import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miz_bazi/page/main/mainPage.dart';
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'mize bazi',
      theme: ThemeData(
        fontFamily: 'vazir',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  Directionality(textDirection: TextDirection.rtl,
        child:MainPage(),
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}