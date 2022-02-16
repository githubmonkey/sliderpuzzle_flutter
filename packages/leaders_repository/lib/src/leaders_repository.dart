import 'package:leaders_api/leaders_api.dart';

/// {@template leaders_repository}
/// A repository that handles leaderboard related requests.
/// {@endtemplate}
class LeadersRepository {
  /// {@macro leaders_repository}
  const LeadersRepository({
    required LeadersApi leadersApi,
  }) : _leadersApi = leadersApi;

  final LeadersApi _leadersApi;

  /// Provides a [Stream] of all leaders.
  Stream<List<Leader>> getLeaders({int? time}) =>
      _leadersApi.getLeaders(time: time);

  /// Saves a [leader].
  ///
  /// If a [leader] with the same id already exists, it will be replaced.
  Future<void> saveLeader(Leader leader) => _leadersApi.saveLeader(leader);
}
