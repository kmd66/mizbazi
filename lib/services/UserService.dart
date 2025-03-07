import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/appHttp.dart';
import '../core/event.dart';
import '../model/ApiModel.dart';
import '../model/Message.dart';

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

  Future Edite(SendSecurityStampDto model) async{
    streamLoad.add('');
    await _http.post(AppStrings.apiHost + urlEdite, {}).then((value) async {
      SharedPreferences local = await SharedPreferences.getInstance();
      await local.setString("auth",value);
      chengStateMain.add(ChengState(StateType.splash));
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
    AppStrings.userAvatar = userAvatar;
  }
}