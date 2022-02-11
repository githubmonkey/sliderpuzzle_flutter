// ignore_for_file: public_member_api_docs

part of 'mswap_puzzle_bloc.dart';

abstract class MswapPuzzleEvent extends Equatable {
  const MswapPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class MswapCountdownStarted extends MswapPuzzleEvent {
  const MswapCountdownStarted();
}

class MswapCountdownTicked extends MswapPuzzleEvent {
  const MswapCountdownTicked();
}

class MswapCountdownStopped extends MswapPuzzleEvent {
  const MswapCountdownStopped();
}

/// Reset and autostart
class MswapCountdownRestart extends MswapPuzzleEvent {
  const MswapCountdownRestart({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [MswapPuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}

/// Reset only, more lightweight than full restart.
/// Fresh initialization but no autostart
class MswapCountdownReset extends MswapPuzzleEvent {
  const MswapCountdownReset();
}
