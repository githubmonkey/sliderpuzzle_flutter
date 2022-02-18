// ignore_for_file: public_member_api_docs

part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class LeaderboardSubscriptionRequested extends LeaderboardEvent {
  const LeaderboardSubscriptionRequested();
}

class LeaderboardLeaderSaved extends LeaderboardEvent {
  const LeaderboardLeaderSaved(this.leader);

  final Leader leader;

  @override
  List<Object> get props => [leader];
}

class LeaderboardFilterChanged extends LeaderboardEvent {
  const LeaderboardFilterChanged(this.filter);

  final LeadersViewFilter filter;

  @override
  List<Object> get props => [filter];
}
