import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;
import 'package:shelf_web_socket/shelf_web_socket.dart' show webSocketHandler;
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

FutureOr<Response> messageHandler(Request request) async =>
    await webSocketHandler(_onConnection)(request);

void _onConnection(WebSocketChannel webSocket) {
  webSocket.sink.add('You are connected!');
  webSocket.stream.listen(
    (v) => print(v.toString()),
    onDone: () => print('Disconnected!'),
  );
}
