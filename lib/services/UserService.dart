import 'dart:convert';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/appHttp.dart';
import '../core/event.dart';
import '../core/extensions.dart';
import '../model/Message.dart';
import '../page/main/constText.dart';

const String urlGet = "api/v1/User/Get";
const String urlGetAvatar = "api/v1/User/GetAvatar";
const String urlEdite = "api/v1/User/Edit";

class UserService {
  var _http = AppHttp();

  Future Get() async{
    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlGet, {}).then((value) async{
      AppStrings.user = value;
      if(value['userName'] != null) {
        chengStateMain.add(ChengState(StateType.home));
      }
      else{
        chengStateMain.add(ChengState(StateType.register));
      }
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
    });
    streamLoad.add(null);
  }

  Future GetAvatar() async{
    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlGetAvatar, {}).then((value) async {
      if(value != null){
        await _setUserAvatarToLocal(value);
      }
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
    });
    streamLoad.add(null);
  }

  Future Edite(dynamic model) async{
    if(DynamicExtra.length(model['lastName']) < 4 || DynamicExtra.length(model['firstName']) < 4){
      streamMessage.add(Message.danger(msg:USER_ERROR1, respite: 5));
      return;
    }
    if(DynamicExtra.length(model['userName']) < 5){
      streamMessage.add(Message.danger(msg:USER_ERROR2, respite: 5));
      return;
    }

    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlEdite, model).then((value) async {
      AppStrings.user['firstName']=model['firstName'];
      AppStrings.user['lastName']=model['lastName'];
      AppStrings.user['userName']=model['userName'];
      chengStateMain.add(ChengState(StateType.home));
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
    });
    streamLoad.add(null);
  }

  Future _setUserAvatarToLocal(String userAvatar) async{
    SharedPreferences local = await SharedPreferences.getInstance();
    if(local.containsKey('userAvatar')){
      await local.remove("userAvatar");
    }
    await local.setString('userAvatar', userAvatar);
    AppStrings.userAvatar = base64Decode(userAvatar);
  }
}