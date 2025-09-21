import 'appSettings.dart';
import 'dart:convert';

class WebPropertis {

  static String get  apiProperty =>  _apiProperty();
  static String _apiProperty() {
    String url =AppStrings.apiHost;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return """
      publicToken = '${AppStrings.auth}';
      publicDeviceId = '${AppStrings.deviceId}';
      publicHubBaseUrl = '$url';
      publicApiBaseUrl = '$url';
      """;
  }

  static String gameProperty(String j) {
    final Map obj = json.decode(j);
    String url =AppStrings.apiHost;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return """
      publicToken = '${AppStrings.auth}';
      publicDeviceId = '${AppStrings.deviceId}';
      publicHubBaseUrl = '${WebPropertis.url(obj['BaseUrl'])}';
      publicApiBaseUrl = '$url';
      """;
  }
  static String url(dynamic url){
    if(url == null || url == '') return '';
    String url0 = url;
    if(url0.contains('localhost:')){
      url0 = url0.replaceAll('localhost:', '10.0.3.2:');
    }
    return url0;
  }
}