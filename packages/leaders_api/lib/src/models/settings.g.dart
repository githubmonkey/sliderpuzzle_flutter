// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      boardSize: json['boardSize'] as int,
      game: $enumDecode(_$GameEnumMap, json['game']),
      elevenToTwenty: json['elevenToTwenty'] as bool,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'boardSize': instance.boardSize,
      'game': _$GameEnumMap[instance.game],
      'elevenToTwenty': instance.elevenToTwenty,
    };

const _$GameEnumMap = {
  Game.multi: 'multi',
  Game.addition: 'addition',
  Game.hex: 'hex',
  Game.binary: 'binary',
  Game.roman: 'roman',
  Game.noop: 'noop',
};
