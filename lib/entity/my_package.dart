// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vs1/entity/details.dart';
import 'package:vs1/entity/location.dart';
import 'package:vs1/entity/package.dart';
import 'package:vs1/entity/stage.dart';

class MyPackage {
  Stage stage;
  int id;
  String created_at;
  Details origin_details;
  List<Details> destination_details;
  PackageDetails package_details;
  String uuid;
  String id_user;
  MyLocation coordinat;
  MyPackage({
    required this.stage,
    required this.id,
    required this.created_at,
    required this.origin_details,
    required this.destination_details,
    required this.package_details,
    required this.uuid,
    required this.id_user,
    required this.coordinat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stage': stage.toMap(),
      'id': id,
      'created_at': created_at,
      'origin_details': origin_details.toMap(),
      'destination_details': destination_details.map((x) => x.toMap()).toList(),
      'package_details': package_details.toMap(),
      'uuid': uuid,
      'id_user': id_user,
      'coordinat': coordinat.toMap(),
    };
  }

  factory MyPackage.fromMap(Map<String, dynamic> map) {
    return MyPackage(
      stage: Stage.fromMap(map['stage'] as Map<String, dynamic>),
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      origin_details:
          Details.fromMap(map['origin_details'] as Map<String, dynamic>),
      destination_details: List<Details>.from(
        (map['destination_details'] as List<dynamic>).map<Details>(
          (x) => Details.fromMap(x as Map<String, dynamic>),
        ),
      ),
      package_details: PackageDetails.fromMap(
          map['package_details'] as Map<String, dynamic>),
      uuid: map['uuid'] as String,
      id_user: map['id_user'] as String,
      coordinat: MyLocation.fromMap(map['coordinat'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPackage.fromJson(String source) =>
      MyPackage.fromMap(json.decode(source) as Map<String, dynamic>);
}
