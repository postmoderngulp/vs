// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class card extends ChangeNotifier {
  String picture;
  String title;
  String label;
  card({
    required this.picture,
    required this.title,
    required this.label,
  });
}
