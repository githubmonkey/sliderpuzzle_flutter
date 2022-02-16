// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leader _$LeaderFromJson(Map<String, dynamic> json) => Leader(
      id: json['id'] as String?,
      userid: json['userid'] as String,
      nickname: json['nickname'] as String? ?? '',
      settings: json['settings'] as String,
      time: json['time'] as int,
      moves: json['moves'] as int,
    );

Map<String, dynamic> _$LeaderToJson(Leader instance) => <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'nickname': instance.nickname,
      'settings': instance.settings,
      'time': instance.time,
      'moves': instance.moves,
    };
