// ignore_for_file: public_member_api_docs

part of 'mslide_puzzle_bloc.dart';

/// The status of [MslidePuzzleState].
enum MslidePuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

// WARNING: keep order, it is matched to countdown seconds
enum LaunchStages {
  finished,
  scatterAnswers,
  showAnswers,
  showQuestions,
  resetting
}

class MslidePuzzleState extends Equatable {
  const MslidePuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
    this.isPaused = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// Indicates if the timer is stopped
  final bool isPaused;

  /// The status of the current puzzle.
  MslidePuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? MslidePuzzleStatus.loading
      : (secondsToBegin == 0
          ? MslidePuzzleStatus.started
          : MslidePuzzleStatus.notStarted);

  LaunchStages get launchStage => LaunchStages.values[secondsToBegin];

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin, isPaused];

  MslidePuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
    bool? isPaused,
  }) {
    return MslidePuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      isPaused: isPaused ?? this.isPaused,
    );
  }
}
