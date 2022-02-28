// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';

part 'settings.g.dart';

enum Game { multi, addition, hex, binary, roman, noop }

/// {@template leader}
/// A single settings entry.
///
/// [Settings]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Settings extends Equatable {
  /// {@macro leader}
  const Settings({
    required this.boardSize,
    required this.game,
    required this.elevenToTwenty,
    //required this.withClues,
  });

  final int boardSize;
  final Game game;
  final bool elevenToTwenty;
  //final bool withClues;

  /// Returns a copy of this Settings with the given values updated.
  ///
  /// {@macro settings}
  Settings copyWith({
    int? boardSize,
    Game? game,
    bool? elevenToTwenty,
    //bool? withClues,
  }) {
    return Settings(
      boardSize: boardSize ?? this.boardSize,
      game: game ?? this.game,
      elevenToTwenty: elevenToTwenty ?? this.elevenToTwenty,
      //withClues: withClues ?? this.withClues,
    );
  }

  /// Deserializes the given [JsonMap] into a [Settings].
  static Settings fromJson(JsonMap json) => _$SettingsFromJson(json);

  /// Converts this [Settings] into a [JsonMap].
  JsonMap toJson() => _$SettingsToJson(this);

  @override
  List<Object> get props => [boardSize, game, elevenToTwenty]; // withClues];
}
