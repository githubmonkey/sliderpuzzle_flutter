// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';

part 'result.g.dart';

/// {@template result}
/// A single result pair
///
/// [Result]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Result extends Equatable implements Comparable<Result> {
  /// {@macro leader}
  const Result({
    required this.time,
    required this.moves,
  });

  /// time in seconds
  final int time;
  final int moves;

  /// convenience converter
  Duration get timeAsDuration => Duration(seconds: time);

  /// Returns a copy of this Settings with the given values updated.
  ///
  /// {@macro settings}
  Result copyWith({
    int? time,
    int? moves,
  }) {
    return Result(
      time: time ?? this.time,
      moves: moves ?? this.moves,
    );
  }

  /// Deserializes the given [JsonMap] into a [Result].
  static Result fromJson(JsonMap json) => _$ResultFromJson(json);

  /// Converts this [Result] into a [JsonMap].
  JsonMap toJson() => _$ResultToJson(this);

  @override
  List<Object> get props => [time, moves];

  @override
  int compareTo(Result other) {
    if (time == other.time && moves == other.moves) return 0;

    if (time < other.time ||
        (time == other.time && moves < other.moves)) {
      return -1;
    }

    return 1;
  }
}
