// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vs1/entity/details.dart';
import 'package:vs1/entity/package.dart';

class PackageInfo {
  Details originDetail;
  List<Details> destinationDetails;
  PackageDetails package;
  PackageInfo({
    required this.originDetail,
    required this.destinationDetails,
    required this.package,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originDetail': originDetail.toMap(),
      'destinationDetails': destinationDetails.map((x) => x.toMap()).toList(),
      'package': package.toMap(),
    };
  }

  factory PackageInfo.fromMap(Map<String, dynamic> map) {
    return PackageInfo(
      originDetail:
          Details.fromMap(map['originDetail'] as Map<String, dynamic>),
      destinationDetails: List<Details>.from(
        (map['destinationDetails'] as List<dynamic>).map<Details>(
          (x) => Details.fromMap(x as Map<String, dynamic>),
        ),
      ),
      package: PackageDetails.fromMap(map['package'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageInfo.fromJson(String source) =>
      PackageInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
