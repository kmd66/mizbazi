import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:miz_bazi/core/appSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/appHttp.dart';
import '../core/event.dart';
import '../model/Message.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:convert';

const String urlDownloadList = "api/app/DownloadList";
const String urlUpdateList = "api/app/UpdateList";

class DownloadAssets {
  var _http = AppHttp();
  final _dio = Dio();

  Future CheckUpdate() async{
    SharedPreferences local = await SharedPreferences.getInstance();

    dynamic list;
    dynamic listData = [];

    list = await _getDownloadList();
    if(list == false || list.length == 0) {
      return;
    }

    if(local.containsKey('appVersion')){
      var listJson = await local.getString('appVersion');
      listData = jsonDecode(listJson!);
    }

    await _chekDownload(list, listData);

    if(local.containsKey('appVersion')){
      await local.remove("appVersion");
    }
    String json = jsonEncode(list);
    await local.setString("appVersion", json);
  }

  Future<dynamic> _getDownloadList() async{
    return  await _http.post(AppStrings.apiHost + urlDownloadList, {}).then((value) async{
      return value;
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
      return false;
    });
  }

  Future<dynamic> _getUpdateList() async{
    return  await _http.post(AppStrings.apiHost + urlUpdateList, {}).then((value) async{
      return value;
    }).catchError((e) {
      streamMessage.add(Message.danger(msg:e['message'], respite: 5));
      return false;
    });
  }

  Future _chekDownload(dynamic list, dynamic localList) async {
    final local = localList as List;
    final items = list as List;

    for (var item in items) {
      final String dirName = await _dirName(item);
      final String fileName = _fileName(item);
      final filePath = path.join(dirName, fileName);

      if(item['type'] == 'delete'){
        await _deleteFile(filePath);
      }
      else {
        var localItem = _getItemInLocal(item, local);
        if(localItem == null || item['version'] != localItem['version']){
          await _deleteFile(filePath);
          await _download(item, filePath);
          if(item['htmlName'] != null){
            await _downloadHtml(item, filePath);
            await _deleteFile(filePath);
          }
        }
      }
    }
  }

  Future _download(dynamic item, String fullPath) async {
    try {
      String url = _url(item['downloadUrl']);
      await _dio.download(
        url,
        fullPath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
    } catch (e) {
      streamMessage.add(Message.danger(msg:e.toString(), respite: 5));
      throw Exception('خطا$e');
    }
  }

  Future _downloadHtml(dynamic item, String fullPath) async {

    // Future<List<int>> processCssImages(dynamic cssData) async {
    //
    //   var  cssContent =  utf8.decode(cssData);
    //   cssContent = cssContent.replaceAll("url('", "url('file://${AppStrings.downloadPath}");
    //   return  utf8.encode(cssContent);
    // }

    try {
      final file = File(fullPath);
      String content = await file.readAsString();

      final document = parse(content);

      Future<void> inlineTag(String tag, String attr, String mimeType) async {
        for (var node in document.querySelectorAll(tag)) {
          final link = node.attributes[attr];
          final cache = node.attributes['cache'];
          if((cache == 'inPage' || tag == 'img') && link != null && !link.startsWith('http')){
            try{
              String baseUrl = _url(item['baseUrl']);
              final res = await _dio.get("$baseUrl/$link",options: Options(responseType: ResponseType.bytes));
              // if(tag == 'link') {
              //   res.data = await processCssImages(res.data);
              // }
              final base64 = base64Encode(res.data);
              final dataUri = "data:$mimeType;base64,$base64";
              node.attributes[attr] = dataUri;
            }
            catch(e){
              print('------------e $e');
            }
          }
          else if (link != null){
            node.attributes[attr] ='.$link';
          }
        }
      }

      await inlineTag("link", "href", "text/css");
      await inlineTag("script", "src", "application/javascript");
      await inlineTag("img", "src", "image/jpeg");
      var finalHtml = document.outerHtml;

      final file2 = File('$fullPath.html');
      await file2.writeAsString(finalHtml);

    } catch (e) {
      streamMessage.add(Message.danger(msg:e.toString()));
      throw Exception('خطا$e');
    }
  }

  dynamic _getItemInLocal(dynamic item, List<dynamic> local) {
    final existingItem = local.firstWhere(
          (x) => item['downloadUrl'].toString()  == x['downloadUrl'].toString(),
      orElse: () => null,
    );
    return existingItem;
  }

  String _fileName(dynamic item) {
    if(item['htmlName'] != null){
      return item['htmlName'];
    }
    int lastSlashIndex = item['downloadUrl'].lastIndexOf('/');
    String fileName = item['downloadUrl'].substring(lastSlashIndex + 1);
    return fileName;
  }

  Future _deleteFile(String path) async {
    final file = File(path);
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } on FileSystemException catch (e) {
      streamMessage.add(Message.danger(msg:e.message));
      throw Exception('خطا${e.message}');
    }
  }

  Future<String> _dirName(dynamic item) async {
    if(item['dirName'] == null){
      return AppStrings.downloadPath!;
    }
    String? folder = item['dirName'];

    final folderPath = path.join(AppStrings.downloadPath!, folder);
    final directory = Directory(folderPath);

    if (await directory.exists()) {
      return folderPath;
    } else {
      await directory.create(recursive: true);
      return folderPath;
    }
  }

  String _url(dynamic url){

    if(url == null || url == '') return '';
    String _url = url;
    if(_url.contains('localhost:')){
      _url = _url.replaceAll('localhost:', '10.0.3.2:');
    }
    return _url;
  }
}