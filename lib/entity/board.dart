// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class board {
  String title;
  String label;
  String picture;
  double width;
  double height;
  board({
    required this.title,
    required this.label,
    required this.picture,
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'label': label,
      'picture': picture,
      'width': width,
      'height': height,
    };
  }

  factory board.fromMap(Map<String, dynamic> map) {
    return board(
      title: map['title'] as String,
      label: map['label'] as String,
      picture: map['picture'] as String,
      width: map['width'] as double,
      height: map['height'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory board.fromJson(String source) =>
      board.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant board other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.label == label &&
        other.picture == picture &&
        other.width == width &&
        other.height == height;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        label.hashCode ^
        picture.hashCode ^
        width.hashCode ^
        height.hashCode;
  }
}
