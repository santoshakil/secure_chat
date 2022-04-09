import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/info/info_api.dart';
import '../model/room_model.dart';

final activeRooms = StateProvider((_) => <String>[]);
final roomInfoProvider =
    FutureProvider.family<RoomData?, String>((_, ip) => getUserInfo(ip));
