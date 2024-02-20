import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OriginLocate {
  double lat;
  double long;
  OriginLocate({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
    };
  }

  factory OriginLocate.fromMap(Map<String, dynamic> map) {
    return OriginLocate(
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory OriginLocate.fromJson(String source) =>
      OriginLocate.fromMap(json.decode(source) as Map<String, dynamic>);
}
