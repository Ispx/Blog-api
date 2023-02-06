import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ServerConfig {
  static Future<void> run({
    required String host,
    required int port,
    required Handler handler,
  }) async {
    await shelf_io.serve(handler, host, port);
  }
}
