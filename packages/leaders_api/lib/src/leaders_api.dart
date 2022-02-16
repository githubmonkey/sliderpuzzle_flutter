import 'package:leaders_api/leaders_api.dart';

/// {@template leaders_api}
/// The interface and models for an API providing leaderboard entries.
/// {@endtemplate}
abstract class LeadersApi {
  /// {@macro leaders_api}
  const LeadersApi();

  /// Provides a [Stream] of all leaders.
  ///
  /// //TODO(s): handle time and moves
  /// //TODO(s): retrieve by user
  /// If a time x is given, return everything up to x
  Stream<List<Leader>> getLeaders({int? time});

  /// Saves a [Leader].
  ///
  /// If a [leader] with the same id already exists, it will be replaced.
  Future<void> saveLeader(Leader leader);
}

/// Error thrown when a [Leader] with a given id is not found.
class LeaderNotFoundException implements Exception {}
