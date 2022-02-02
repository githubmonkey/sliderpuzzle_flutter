
import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/widgets/puzzle_grid.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template mslide_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [questions].
/// {@endtemplate}
class MslideChallengeBoard extends StatelessWidget {
  /// {@macro mslide_puzzle_board}
  const MslideChallengeBoard({
    Key? key,
    required this.questions,
    required this.size,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> questions;

  /// The board size
  final int size;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        dimension: _BoardSize.small,
        child: PuzzleGrid(
          key: const Key('mslide_puzzle_board_small'),
          size: size,
          tiles: questions,
        ),
      ),
      medium: (_, child) => SizedBox.square(
        dimension: _BoardSize.medium,
        child: PuzzleGrid(
          key: const Key('mslide_puzzle_board_medium'),
          size: size,
          tiles: questions,
        ),
      ),
      large: (_, child) => SizedBox.square(
        dimension: _BoardSize.large,
        child: PuzzleGrid(
          key: const Key('mslide_puzzle_board_large'),
          size: size,
          tiles: questions,
        ),
      ),
    );
  }
}
