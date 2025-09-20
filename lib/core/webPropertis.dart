
import 'appSettings.dart';

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

  static String gameProperty(String publicHubBaseUrl) {
    String url =AppStrings.apiHost;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return """
      "publicToken = '${AppStrings.auth}';"
      "publicDeviceId = '${AppStrings.deviceId}';"
      "publicHubBaseUrl = '$publicHubBaseUrl';"
      "publicApiBaseUrl = '$url';"
    """;
  }
}