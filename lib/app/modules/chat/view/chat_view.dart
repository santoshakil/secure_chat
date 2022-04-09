import 'package:flutter/material.dart';
import 'package:secure_chat/app/modules/rooms/model/room_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatView extends StatelessWidget {
  final RoomData data;

  const ChatView(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://${data.ip}:8080/message'));
    channel.sink.add('Hello, world!');
    return Scaffold(
      appBar: AppBar(title: Text(data.name)),
    );
  }
}
