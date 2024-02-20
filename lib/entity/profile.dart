// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vs1/entity/history.dart';

class Profile {
  int id;
  String created_at;
  String user_id;
  String phone;
  String name;
  int balance;
  String role;
  List<TransactionHistory> transactions;
  Profile({
    required this.id,
    required this.created_at,
    required this.user_id,
    required this.phone,
    required this.name,
    required this.balance,
    required this.role,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'user_id': user_id,
      'phone': phone,
      'name': name,
      'balance': balance,
      'role': role,
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      user_id: map['user_id'] as String,
      phone: map['phone'] as String,
      name: map['name'] as String,
      balance: map['balance'] as int,
      role: map['role'] as String,
      transactions: map['transactions'] == null  ? [] : List<TransactionHistory>.from(
        (map['transactions'] as List<dynamic>).map<TransactionHistory>(
          (x) => TransactionHistory.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
