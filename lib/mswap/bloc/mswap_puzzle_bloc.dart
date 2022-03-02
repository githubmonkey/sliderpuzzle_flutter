import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'mswap_puzzle_event.dart';
part 'mswap_puzzle_state.dart';

/// {@template mswap_puzzle_bloc}
/// A bloc responsible for starting the mswap puzzle.
/// {@endtemplate}
class MswapPuzzleBloc extends Bloc<MswapPuzzleEvent, MswapPuzzleState> {
  /// {@macro mswap_puzzle_bloc}
  MswapPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(MswapPuzzleState(secondsToBegin: secondsToBegin)) {
    on<MswapCountdownStarted>(_onCountdownStarted);
    on<MswapCountdownTicked>(_onCountdownTicked);
    on<MswapCountdownStopped>(_onCountdownStopped);
    on<MswapCountdownRestart>(_onCountdownRestart);
    on<MswapPuzzlePaused>(_onPuzzlePaused);
    on<MswapPuzzleResumed>(_onPuzzleResumed);
    on<MswapCountdownReset>(_onCountdownReset);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const MswapCountdownTicked()));
  }

  void _onCountdownStarted(
    MswapCountdownStarted event,
    Emitter<MswapPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    MswapCountdownTicked event,
    Emitter<MswapPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    MswapCountdownStopped event,
    Emitter<MswapPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownRestart(
    MswapCountdownRestart event,
    Emitter<MswapPuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
      ),
    );
  }

  void _onPuzzlePaused(
      MswapPuzzlePaused event,
      Emitter<MswapPuzzleState> emit,
      ) {
    _tickerSubscription?.pause();
    emit(state.copyWith(isPaused: true));
  }

  void _onPuzzleResumed(
      MswapPuzzleResumed event,
      Emitter<MswapPuzzleState> emit,
      ) {
    _tickerSubscription?.resume();
    emit(state.copyWith(isPaused: false));
  }

  void _onCountdownReset(
    MswapCountdownReset event,
    Emitter<MswapPuzzleState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: 3,
      ),
    );
  }
}
