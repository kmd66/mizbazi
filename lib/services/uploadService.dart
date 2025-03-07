import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/event.dart';
import '../model/Message.dart';

const String urlAvatar = "api/v1/Upload/Avatar";

class UploadService {

  Future<bool> Avatar(Uint8List file, String fileExtension, String mimeType) async{
    streamLoad.add('');
    var name = md5.convert(utf8.encode(DateTime.now().toString())).toString() + fileExtension;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromBytes(file, filename: name),
    });
    return await _post(AppStrings.apiHost + urlAvatar, formData, mimeType).then((value) {
      return true;
    }).catchError((e){
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
      streamLoad.add(null);
      return false;
    });
  }

  Future<dynamic> _post(String url, FormData model, String mimeType) async {
    try {
      final dio = Dio();
      final response = await dio.post(url,
        options: Options(
          headers: {
            'Auth': AppStrings.auth,
            'D-Id': AppStrings.deviceId,
            "S-Type": mimeType,
            // 'Content-Type': mimeType,
          },
        ),
        data : model,
      );

      if(response.statusCode == 401)
      {
        _error401();
        return;
      }

      if (response.statusCode == 200) {
        if(response.data['Code'] == 401) {
          _error401();
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
          _error401();
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

  void _error401() async{
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