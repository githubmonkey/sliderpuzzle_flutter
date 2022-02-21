// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';
import 'package:leaders_api/leaders_api.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required HistoryRepository historyRepository,
  })  : _historyRepository = historyRepository,
        super(const HistoryState()) {
    on<HistorySubscriptionRequested>(_onSubscriptionRequested);
    on<HistoryLeaderSaved>(_onLeaderSaved);
  }

  final HistoryRepository _historyRepository;

  Future<void> _onSubscriptionRequested(
    HistorySubscriptionRequested event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(status: () => HistoryStatus.loading));

    await emit.forEach<List<Leader>>(
      _historyRepository.getHistory(),
      onData: (leaders) => state.copyWith(
        status: () => HistoryStatus.success,
        leaders: () => leaders,
      ),
      onError: (_, __) => state.copyWith(
        status: () => HistoryStatus.failure,
      ),
    );
  }

  Future<void> _onLeaderSaved(
    HistoryLeaderSaved event,
    Emitter<HistoryState> emit,
  ) async {
    debugPrint('saving leader ${event.leader}');
    await _historyRepository.saveHistory(event.leader);
  }
}
