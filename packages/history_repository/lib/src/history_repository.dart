
import 'package:leaders_api/leaders_api.dart';

/// {@template history_repository}
/// A repository that handles leaderboard related requests.
/// {@endtemplate}
class HistoryRepository {
  /// {@macro history_repository}
  const HistoryRepository({
    required LeadersApi leadersApi,
  }) : _leadersApi = leadersApi;

  final LeadersApi _leadersApi;

  /// Provides a [Stream] of all history.
  Stream<List<Leader>> getHistory({int? time}) =>
      _leadersApi.getHistory(time: time);

  /// Saves a [leader].
  ///
  /// If a [leader] with the same id already exists, it will be replaced.
  Future<void> saveHistory(Leader leader) => _leadersApi.saveHistory(leader);
}
