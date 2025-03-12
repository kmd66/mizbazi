import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/CheckHost.dart';

class AppStrings {
  static loadJson() async {
    String _data = await rootBundle.loadString('assets/appSettings.json');
    var jsonResult = json.decode(_data);
    appVersion =  jsonResult['appVersion'];
    appName =  jsonResult['appName'];
    appComment =  jsonResult['appComment'];

    apiHost =  jsonResult['apiHost'];
  }
  static String appVersion = '';
  static String appName = '';
  static String appComment = '';

  static String apiHost = 'https://10.0.3.2:7230/';
  // static String apiHost = 'https://localhost:7230/';

  static late CheckHost webWersion;

  static String? deviceId;
  static String? auth;
  static dynamic user;
  static Uint8List? userAvatar;
}