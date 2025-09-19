import 'dart:ui';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/appHttp.dart';
import '../core/event.dart';
import '../model/ApiModel.dart';
import '../model/Message.dart';
import 'downloadAssets.dart';

const String urlGetUser = "api/v1/Login/GetUser";
const String urlGetToken = "api/v1/Login/GetToken";

class LoginService {
  var _http = AppHttp();

  Future GetUser(SendSecurityStampDto model,VoidCallback fn) async{
    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlGetUser, model).then((value) {
      fn();
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
    });
    streamLoad.add(null);
  }
  Future GetToken(SendSecurityStampDto model) async{
    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlGetToken, model).then((value) async {
      SharedPreferences local = await SharedPreferences.getInstance();
      await local.setString("auth",value);

      if(local.containsKey('appVersion')){
        await local.remove("appVersion");
      }

      chengStateMain.add(ChengState(StateType.splash));
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
    });
    streamLoad.add(null);
  }
}