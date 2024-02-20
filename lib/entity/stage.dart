import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Stage {
  String stage;
  String stage1Time;
  String stage2Time;
  String stage3Time;
  String stage4Time;
  Stage({
    required this.stage,
    required this.stage1Time,
    required this.stage2Time,
    required this.stage3Time,
    required this.stage4Time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stage': stage,
      'stage1Time': stage1Time,
      'stage2Time': stage2Time,
      'stage3Time': stage3Time,
      'stage4Time': stage4Time,
    };
  }

  factory Stage.fromMap(Map<String, dynamic> map) {
    return Stage(
      stage: map['stage'] as String,
      stage1Time: map['stage1Time'] as String,
      stage2Time: map['stage2Time'] as String,
      stage3Time: map['stage3Time'] as String,
      stage4Time: map['stage4Time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stage.fromJson(String source) =>
      Stage.fromMap(json.decode(source) as Map<String, dynamic>);
}
