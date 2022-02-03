// ignore_for_file: public_member_api_docs

part of 'mslide_puzzle_bloc.dart';

/// The status of [MslidePuzzleState].
enum mslidePuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

enum LaunchStages { finished, scatterAnswers, showAnswers, showQuestions, resetting }

class MslidePuzzleState extends Equatable {
  const MslidePuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  mslidePuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? mslidePuzzleStatus.loading
      : (secondsToBegin == 0
          ? mslidePuzzleStatus.started
          : mslidePuzzleStatus.notStarted);

  LaunchStages get launchStage => LaunchStages.values[secondsToBegin];

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  MslidePuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return MslidePuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
