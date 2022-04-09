import 'dart:convert';

class RoomData {
  String ip;
  String name;

  RoomData({
    required this.ip,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'name': name,
    };
  }

  factory RoomData.fromMap(Map<String, dynamic> map) {
    return RoomData(
      ip: map['ip'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomData.fromJson(String source) =>
      RoomData.fromMap(json.decode(source));

  @override
  String toString() => 'RoomData(ip: $ip, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomData && other.ip == ip && other.name == name;
  }

  @override
  int get hashCode => ip.hashCode ^ name.hashCode;
}
