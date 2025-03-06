import 'package:miz_bazi/core/appSettings.dart';
import '../core/appHttp.dart';
import '../model/CheckHost.dart';

const String urlCheckHost = "api/CheckHost";

class PblService {
  var _http = AppHttp();

  Future<CheckHost> checkHost () async{
    return await _http.post(AppStrings.apiHost + urlCheckHost, {}).then((value) {
      return  value != null ? CheckHost.fromJson(value): CheckHost();
    }).catchError((error) {
      return  CheckHost.error(error);
    });
  }

  Future<CheckHost> testCheckHost () async{
    late CheckHost model;
    var t = CheckHost(webWersion: "asdass");
    await _http.post(AppStrings.apiHost + "api/testCheckHost", t.toJson()).then((value) {
      model =  value != null ?CheckHost.fromJson(value): CheckHost();
    }).catchError((error) {
      model =  CheckHost();
    });
    return model;
  }

  // Future<List<SinaSurvey>> list (SinaSurveyVM model) async{
  //   return await _http.post(model,SurveyController.list).then((value) {
  //     return  value != null ?(value as List).map((x) => SinaSurvey.fromJson(x)).toList():[];
  //   });
  // }
  // Future<String> add(SinaSurveyAddAnswer model) async{
  //   return await _http.post(model,SurveyController.add).then((value) {
  //     return '';
  //   });
  // }
}