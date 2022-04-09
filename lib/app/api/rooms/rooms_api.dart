import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/rooms/provider/rooms_provider.dart';
import '../api.dart';

Future<void> getRooms(WidgetRef ref) async {
  final _ip = await getIP();
  if (_ip == null) return;
  final _subnet = _ip.substring(0, _ip.lastIndexOf('.'));
  final _p = ref.read(activeRooms.state);
  for (int i = 1; i < 256; ++i) {
    // try {
    //   final channel = WebSocketChannel.connect(
    //     Uri.parse('ws://$_subnet.$i:8080/message'),
    //   );
    // } on Exception catch (e) {
    //   print(e.toString());
    // }
    Socket.connect('$_subnet.$i', 8080).then((socket) {
      _p.state = [..._p.state, '$_subnet.$i'];
      socket.destroy();
    }).catchError((_) {});
  }
}
