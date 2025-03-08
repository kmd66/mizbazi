import 'package:dio/dio.dart';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/BaseModel.dart';
import '../model/Message.dart';
import 'event.dart';

class AppHttp {

  Future<dynamic> post(String url, dynamic model) async {
    try {
      late dynamic data;
      if(model is BaseModel)
        data = model.toJson();
      else
        data = model;
      final dio = Dio();
      final response = await dio.post(url,
        options: Options(
          headers: {
            'Auth': AppStrings.auth,
            'D-Id': AppStrings.deviceId,
          },
        ),
        data : data,
      );
      if(response.statusCode == 401)
      {
        error401();
        return;
      }

      if (response.statusCode == 200) {

        if(response.data['code'] == 401) {
          error401();
          return;
        }

        if(response.data['success']) {
          return response.data['data'];
        } else {
          throw {
            'code': response.data['code'],
            'message': response.data['message'],
          };
        }
      }
      else {
        throw {
          'code': response.statusCode,
          'message': response.statusMessage,
        };
      }
    } on  DioException catch (e) {
      if(e.response?.statusCode != null){
        if(e.response?.statusCode == 401){
          error401();
          return;
        }
        throw {
          'code': e.response?.statusCode,
          'message': e.response?.statusMessage,
        };
      }
      throw {
        'code': -100,
        'message': e.message,
      };
    }
  }

  void error401() async{
    chengStateMain.add(ChengState(StateType.empty));
    streamLoad.add(null);
    SharedPreferences local = await SharedPreferences.getInstance();
    if(local.containsKey('auth')){
      await local.remove("auth");
    }
    streamMessage.add(Message.danger(
        msg: 'نشست شما به پایان رسیده است \n برای ادامه مجددا وارد شوید',
        onOk: () {
          chengStateMain.add(ChengState(StateType.splash));
        }
    ));
  }


}