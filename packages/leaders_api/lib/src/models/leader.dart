import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'leader.g.dart';

/// {@template leader}
/// A single leader entry.
///
/// Contains [id], [userid], [nickname], [settings], and [result]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Leader]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
///
/// run 'flutter pub run build_runner build' to regenerte
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Leader extends Equatable {
  /// {@macro leader}
  Leader({
    String? id,
    required this.userid,
    this.nickname = '',
    required this.theme,
    required this.settings,
    required this.result,
    required this.timestamp,
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

  /// The theme name that describes the board config. (Required)
  final String theme;

  /// The settings string that describes the board config. (Required)
  final Settings settings;

  /// The result as time/moves. (Required)
  final Result result;

  /// The timestamp. (Required)
  final DateTime timestamp;

  /// Returns a copy of this Leader with the given values updated.
  ///
  /// {@macro leader}
  Leader copyWith({
    String? id,
    String? userid,
    String? nickname,
    String? theme,
    Settings? settings,
    Result? result,
    DateTime? timestamp,
  }) {
    return Leader(
      id: id ?? this.id,
      userid: userid ?? this.userid,
      nickname: nickname ?? this.nickname,
      theme: theme ?? this.theme,
      settings: settings ?? this.settings,
      result: result ?? this.result,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Deserializes the given [JsonMap] into a [Leader].
  static Leader fromJson(JsonMap json) => _$LeaderFromJson(json);

  /// Converts this [Leader] into a [JsonMap].
  JsonMap toJson() => _$LeaderToJson(this);

  @override
  List<Object> get props => [
        id,
        userid,
        nickname,
        theme,
        settings,
        result,
        timestamp,
      ];
}
