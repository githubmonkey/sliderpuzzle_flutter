import 'package:leaders_api/leaders_api.dart';

/// NOTE: for now the two repos are using the api differently
/// _firestore_repository_ is only using the model but bypasses the api
/// functions in favor of direct fs calls
/// _history_repository_ is using the api functions to access shared prefs via
/// local_history_api

/// {@template leaders_api}
/// The interface and models for an API providing leaderboard entries.
/// {@endtemplate}
abstract class LeadersApi {
  /// {@macro leaders_api}
  const LeadersApi();

  /// Provides a [Stream] of all leaders.
  /// returns all local records regardless of filter settings
  Stream<List<Leader>> getHistory();

  /// Saves a [Leader].
  ///
  /// If a [leader] with the same id already exists, it will be replaced.
  Future<void> saveHistory(Leader leader);
}

/// Error thrown when a [Leader] with a given id is not found.
class LeaderNotFoundException implements Exception {}
