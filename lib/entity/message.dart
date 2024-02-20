import 'dart:convert';

class Message {
  int id;
  String created_at;
  String content;
  String userTo;
  String userFrom;
  bool isRead;
  Message({
    required this.id,
    required this.created_at,
    required this.content,
    required this.userTo,
    required this.userFrom,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'content': content,
      'userTo': userTo,
      'userFrom': userFrom,
      'isRead': isRead,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      content: map['content'] as String,
      userTo: map['userTo'] as String,
      userFrom: map['userFrom'] as String,
      isRead: map['isRead'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
