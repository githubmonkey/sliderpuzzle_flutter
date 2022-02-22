// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:leaders_api/leaders_api.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(const LeaderboardState()) {
    on<LeaderboardLeaderSaved>(_onLeaderSaved);
  }

  final FirestoreRepository _firestoreRepository;

  Future<void> _onLeaderSaved(
    LeaderboardLeaderSaved event,
    Emitter<LeaderboardState> emit,
  ) async {
    // debugPrint('saving leader ${event.leader}');
    await _firestoreRepository.saveLeader(event.leader);
  }
}
