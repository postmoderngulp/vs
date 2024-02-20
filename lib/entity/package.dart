import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PackageDetails {
  String items;
  String weight;
  String worthItems;
  PackageDetails({
    required this.items,
    required this.weight,
    required this.worthItems,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items,
      'weight': weight,
      'worthItems': worthItems,
    };
  }

  factory PackageDetails.fromMap(Map<String, dynamic> map) {
    return PackageDetails(
      items: map['items'] as String,
      weight: map['weight'] as String,
      worthItems: map['worthItems'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageDetails.fromJson(String source) =>
      PackageDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
