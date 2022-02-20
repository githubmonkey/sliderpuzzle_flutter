// ignore_for_file: public_member_api_docs

part of 'leaderboard_bloc.dart';

enum LeaderboardStatus { initial, loading, success, failure }

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.leaders = const [],
  });

  final LeaderboardStatus status;
  final List<Leader> leaders;


  LeaderboardState copyWith({
    LeaderboardStatus Function()? status,
    List<Leader> Function()? leaders,
  }) {
    return LeaderboardState(
      status: status != null ? status() : this.status,
      leaders: leaders != null ? leaders() : this.leaders,
    );
  }

  @override
  List<Object?> get props => [status, leaders];
}
