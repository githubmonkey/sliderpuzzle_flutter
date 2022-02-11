// ignore_for_file: public_member_api_docs

part of 'mslide_puzzle_bloc.dart';

abstract class MslidePuzzleEvent extends Equatable {
  const MslidePuzzleEvent();

  @override
  List<Object?> get props => [];
}

class MslideCountdownStarted extends MslidePuzzleEvent {
  const MslideCountdownStarted();
}

class MslideCountdownTicked extends MslidePuzzleEvent {
  const MslideCountdownTicked();
}

class MslideCountdownStopped extends MslidePuzzleEvent {
  const MslideCountdownStopped();
}

/// Reset and autostart
class MslideCountdownRestart extends MslidePuzzleEvent {
  const MslideCountdownRestart({this.secondsToBegin});

  /// The number of seconds to countdown from.
  /// Defaults to [MslidePuzzleBloc.secondsToBegin] if null.
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
}

/// Reset only, more lightweight than full restart.
/// Fresh initialization but no autostart
class MslideCountdownReset extends MslidePuzzleEvent {
  const MslideCountdownReset();
}
