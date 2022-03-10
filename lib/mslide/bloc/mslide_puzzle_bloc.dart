import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'mslide_puzzle_event.dart';
part 'mslide_puzzle_state.dart';

/// {@template mslide_puzzle_bloc}
/// A bloc responsible for starting the mslide puzzle.
/// {@endtemplate}
class MslidePuzzleBloc extends Bloc<MslidePuzzleEvent, MslidePuzzleState> {
  /// {@macro mslide_puzzle_bloc}
  MslidePuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
  })  : _ticker = ticker,
        super(MslidePuzzleState(secondsToBegin: secondsToBegin)) {
    on<MslideCountdownStarted>(_onCountdownStarted);
    on<MslideCountdownTicked>(_onCountdownTicked);
    on<MslideCountdownStopped>(_onCountdownStopped);
    on<MslideCountdownRestart>(_onCountdownRestart);
    on<MslidePuzzlePaused>(_onPuzzlePaused);
    on<MslidePuzzleResumed>(_onPuzzleResumed);
    on<MslideCountdownReset>(_onCountdownReset);
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
        _ticker.tick().listen((_) => add(const MslideCountdownTicked()));
  }

  void _onCountdownStarted(
    MslideCountdownStarted event,
    Emitter<MslidePuzzleState> emit,
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
    MslideCountdownTicked event,
    Emitter<MslidePuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(state.copyWith(isCountdownRunning: false));
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    MslideCountdownStopped event,
    Emitter<MslidePuzzleState> emit,
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
    MslideCountdownRestart event,
    Emitter<MslidePuzzleState> emit,
  ) {
    _startTicker();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: event.secondsToBegin ?? secondsToBegin,
        isPaused: false,
      ),
    );
  }

  void _onPuzzlePaused(
    MslidePuzzlePaused event,
    Emitter<MslidePuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(state.copyWith(isPaused: true));
  }

  void _onPuzzleResumed(
    MslidePuzzleResumed event,
    Emitter<MslidePuzzleState> emit,
  ) {
    _tickerSubscription?.resume();
    emit(state.copyWith(isPaused: false));
  }

  void _onCountdownReset(
    MslideCountdownReset event,
    Emitter<MslidePuzzleState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: 3,
        isPaused: false,
      ),
    );
  }
}
