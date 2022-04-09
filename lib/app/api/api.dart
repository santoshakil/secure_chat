import 'package:network_info_plus/network_info_plus.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../utils/constants/constants.dart';
import 'chat/chat_api.dart';
import 'info/info_api.dart';

String? deviceIP;
Future<String?> getIP() async {
  deviceIP = await NetworkInfo().getWifiIP();
  return deviceIP;
}

Future<void> initAPIs() async {
  final _handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_handlers);
  final server = await serve(_handler, serverIP, serverPort);
  print('Serving at http://${server.address.address}:${server.port}');
}

final _handlers = Router()
  ..get('/info', getInfoHandler)
  ..get('/message', messageHandler)
  ..get('/ping', (_) => Response.ok(''));
