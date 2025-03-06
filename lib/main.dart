import 'package:flutter/material.dart';
import 'package:miz_bazi/page/main/mainPage.dart';
import 'dart:ui';

void main() {
  // HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'mize bazi',
      theme: ThemeData(fontFamily: 'Tahoma',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  Directionality(textDirection: TextDirection.rtl,
        child:MainPage(),
      ),
    ),
  );
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}