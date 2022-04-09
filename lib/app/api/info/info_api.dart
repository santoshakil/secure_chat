import 'dart:async';

import 'package:secure_chat/app/modules/rooms/model/room_model.dart';
import 'package:shelf/shelf.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

FutureOr<Response> getInfoHandler(Request request) async {
  if (deviceIP == null) getIP();
  if (deviceIP == null) return Response.notFound('Not found');
  final _data = RoomData(ip: deviceIP!, name: DateTime.now().toString());
  return Response.ok(_data.toJson());
}

Future<RoomData?> getUserInfo(String ip) async {
  var request = http.Request('GET', Uri.parse('http://$ip:8080/info'));
  http.StreamedResponse response = await request.send();
  if (response.statusCode != 200) return null;
  return RoomData.fromJson(await response.stream.bytesToString());
}
