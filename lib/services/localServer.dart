import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

class LocalServer  {
  static final LocalServer _instance = LocalServer._internal();

  factory LocalServer() => _instance;

  LocalServer._internal();

  HttpServer? _server;

  /// راه‌اندازی سرور با مسیر فایل‌ها و پورت مشخص
  Future<void> start({required String folderPath, int port = 8080}) async {
    if (_server != null) {
      return;
    }

    var handler = createStaticHandler(
      folderPath,
      serveFilesOutsidePath: true,
      defaultDocument: 'index.html',
    );

    // bind به 0.0.0.0 تا از Genymotion و شبیه‌سازهای دیگه قابل دسترسی باشه
    _server = await io.serve(handler, '0.0.0.0', port);
  }

  /// توقف سرور
  Future<void> stop() async {
    if (_server != null) {
      await _server!.close(force: true);
      _server = null;
    }
  }

  /// بررسی وضعیت سرور
  bool get isRunning => _server != null;
}
