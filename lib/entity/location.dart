// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:vs1/entity/origin_locate.dart';

class MyLocation {
  OriginLocate location;
  List<OriginLocate> locations;
  MyLocation({
    required this.location,
    required this.locations,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'locations': locations.map((x) => x.toMap()).toList(),
    };
  }

  factory MyLocation.fromMap(Map<String, dynamic> map) {
    return MyLocation(
      location: OriginLocate.fromMap(map['location'] as Map<String, dynamic>),
      locations: List<OriginLocate>.from(
        (map['locations'] as List<dynamic>).map<OriginLocate>(
          (x) => OriginLocate.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyLocation.fromJson(String source) =>
      MyLocation.fromMap(json.decode(source) as Map<String, dynamic>);
}
