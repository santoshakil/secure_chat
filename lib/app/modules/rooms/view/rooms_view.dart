import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_chat/app/modules/rooms/model/room_model.dart';

import '../../../api/rooms/rooms_api.dart';
import '../../chat/view/chat_view.dart';
import '../provider/rooms_provider.dart';

class RoomsView extends ConsumerWidget {
  const RoomsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getRooms(ref);
    return Scaffold(
      appBar: AppBar(elevation: 0.0, title: const Text('Chats')),
      body: RefreshIndicator(
        onRefresh: () async => getRooms(ref),
        child: Consumer(
          builder: (_, ref, __) {
            final _data = ref.watch(activeRooms);
            return ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, i) {
                final _info = ref.watch(roomInfoProvider(_data[i]));
                return _info.when(
                  data: (v) => v != null
                      ? _RoomTile(v)
                      : ListTile(title: Text(_data[i])),
                  error: (_, __) => ListTile(title: Text(_data[i])),
                  loading: () => const ListTile(title: Text('Loading...')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  final RoomData data;

  const _RoomTile(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name),
      onTap: () async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChatView(data)),
      ),
    );
  }
}
