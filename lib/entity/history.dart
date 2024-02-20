import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionHistory {
  String price;
  String created_at;
  String date;
  String body;
  TransactionHistory({
    required this.price,
    required this.created_at,
    required this.date,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'created_at': created_at,
      'date': date,
      'body': body,
    };
  }

  factory TransactionHistory.fromMap(Map<String, dynamic> map) {
    return TransactionHistory(
      price: map['price'] as String,
      created_at: map['created_at'] as String,
      date: map['date'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionHistory.fromJson(String source) =>
      TransactionHistory.fromMap(json.decode(source) as Map<String, dynamic>);
}
