import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Details {
  String address;
  String state;
  String number;
  String others;
  Details({
    required this.address,
    required this.state,
    required this.number,
    required this.others,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'state': state,
      'number': number,
      'others': others,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      address: map['address'] as String,
      state: map['state'] as String,
      number: map['number'] as String,
      others: map['others'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) =>
      Details.fromMap(json.decode(source) as Map<String, dynamic>);
}
