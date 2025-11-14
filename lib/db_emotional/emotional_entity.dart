import 'dart:convert';
import 'package:intl/intl.dart';

class EmotionalEntity {
  int id;
  DateTime createdTime;
  int type;
  String content;
  int intensity;
  List<String> triggers;
  List<String> physicalFeelings;
  String? reflection;
  DateTime? reflectionTime;

  EmotionalEntity({
    required this.id,
    required this.createdTime,
    required this.type,
    required this.content,
    required this.intensity,
    required this.triggers,
    required this.physicalFeelings,
    this.reflection,
    this.reflectionTime,
  });

  factory EmotionalEntity.fromJson(Map<String, dynamic> json) {
    return EmotionalEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      type: json['type'],
      content: json['content'],
      intensity: json['intensity'] ?? 3,
      triggers: json['triggers'] != null
          ? List<String>.from(jsonDecode(json['triggers']))
          : [],
      physicalFeelings: json['physicalFeelings'] != null
          ? List<String>.from(jsonDecode(json['physicalFeelings']))
          : [],
      reflection: json['reflection'],
      reflectionTime: json['reflectionTime'] != null
          ? DateTime.parse(json['reflectionTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'type': type,
      'content': content,
      'intensity': intensity,
      'triggers': jsonEncode(triggers),
      'physicalFeelings': jsonEncode(physicalFeelings),
      'reflection': reflection,
      'reflectionTime': reflectionTime?.toIso8601String(),
    };
  }

  String get createdTimeStr => DateFormat('MM/dd/yyyy HH:mm').format(createdTime);
  
  String get intensityStars => '★' * intensity + '☆' * (5 - intensity);
  
  bool get hasReflection => reflection != null && reflection!.isNotEmpty;
  
  String get triggersDisplay => triggers.isEmpty ? 'None' : triggers.join(', ');
  
  String get physicalFeelingsDisplay => 
      physicalFeelings.isEmpty ? 'None' : physicalFeelings.join(', ');
}