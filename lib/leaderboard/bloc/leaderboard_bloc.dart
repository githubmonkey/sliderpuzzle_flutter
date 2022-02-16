// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leaders_repository/leaders_repository.dart';
import 'package:very_good_slide_puzzle/leaderboard/leaderboard.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc({
    required LeadersRepository leadersRepository,
  })  : _leadersRepository = leadersRepository,
        super(const LeaderboardState()) {
    on<LeaderboardSubscriptionRequested>(_onSubscriptionRequested);
    on<LeaderboardLeaderSaved>(_onLeaderSaved);
    on<LeaderboardFilterChanged>(_onFilterChanged);
  }

  final LeadersRepository _leadersRepository;

  Future<void> _onSubscriptionRequested(
    LeaderboardSubscriptionRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(status: () => LeaderboardStatus.loading));

    await emit.forEach<List<Leader>>(
      _leadersRepository.getLeaders(),
      onData: (leaders) => state.copyWith(
        status: () => LeaderboardStatus.success,
        leaders: () => leaders,
      ),
      onError: (_, __) => state.copyWith(
        status: () => LeaderboardStatus.failure,
      ),
    );
  }

  Future<void> _onLeaderSaved(
    LeaderboardLeaderSaved event,
    Emitter<LeaderboardState> emit,
  ) async {
    await _leadersRepository.saveLeader(event.leader);
  }

  void _onFilterChanged(
    LeaderboardFilterChanged event,
    Emitter<LeaderboardState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
