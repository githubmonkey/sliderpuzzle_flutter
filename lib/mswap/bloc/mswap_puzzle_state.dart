// ignore_for_file: public_member_api_docs

part of 'mswap_puzzle_bloc.dart';

/// The status of [MswapPuzzleState].
enum mswapPuzzleStatus {
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

class MswapPuzzleState extends Equatable {
  const MswapPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// The status of the current puzzle.
  mswapPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? mswapPuzzleStatus.loading
      : (secondsToBegin == 0
          ? mswapPuzzleStatus.started
          : mswapPuzzleStatus.notStarted);

  LaunchStages get launchStage => LaunchStages.values[secondsToBegin];

  @override
  List<Object> get props => [isCountdownRunning, secondsToBegin];

  MswapPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
  }) {
    return MswapPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
    );
  }
}
