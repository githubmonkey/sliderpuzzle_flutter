// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leader _$LeaderFromJson(Map<String, dynamic> json) => Leader(
      id: json['id'] as String?,
      userid: json['userid'] as String,
      nickname: json['nickname'] as String? ?? '',
      theme: json['theme'] as String,
      settings: Settings.fromJson(json['settings'] as Map<String, dynamic>),
      time: json['time'] as int,
      moves: json['moves'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$LeaderToJson(Leader instance) => <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'nickname': instance.nickname,
      'theme': instance.theme,
      'settings': instance.settings.toJson(),
      'time': instance.time,
      'moves': instance.moves,
      'timestamp': instance.timestamp.toIso8601String(),
    };
