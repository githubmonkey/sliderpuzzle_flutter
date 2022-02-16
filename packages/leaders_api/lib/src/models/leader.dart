import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'leader.g.dart';

/// {@template leader}
/// A single leader entry.
///
/// Contains [id], [userid], [nickname], [settings], [time], and [moves]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Leader]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Leader extends Equatable {
  /// {@macro leader}
  Leader({
    String? id,
    required this.userid,
    this.nickname = '',
    required this.settings,
    required this.time,
    required this.moves,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the leader entry. (Required!)
  final String id;

  /// The identifier of the user. (Might be empty)
  final String userid;

  /// The display name the user has chosen. (Might be empty)
  final String nickname;

  /// The settings string that describes the board config. (Required)
  /// //TODO(s): handle flattening of settings
  final String settings;

  /// The time in seconds. (Required)
  final int time;

  /// The number of moves. (Required)
  final int moves;

  /// Returns a copy of this Leader with the given values updated.
  ///
  /// {@macro leader}
  Leader copyWith({
    String? id,
    String? userid,
    String? nickname,
    String? settings,
    int? time,
    int? moves,
  }) {
    return Leader(
      id: id ?? this.id,
      userid: userid ?? this.userid,
      nickname: nickname ?? this.nickname,
      settings: settings ?? this.settings,
      time: time ?? this.time,
      moves: moves ?? this.moves,
    );
  }

  /// Deserializes the given [JsonMap] into a [Leader].
  static Leader fromJson(JsonMap json) => _$LeaderFromJson(json);

  /// Converts this [Leader] into a [JsonMap].
  JsonMap toJson() => _$LeaderToJson(this);

  @override
  List<Object> get props => [id, userid, nickname, settings, time, moves];
}
