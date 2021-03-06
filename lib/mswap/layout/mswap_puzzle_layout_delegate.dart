import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/leaderboard/widgets/stats_block.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/mswap/widgets/mswap_challenge_board.dart';
import 'package:very_good_slide_puzzle/mswap/widgets/mswap_question_tile.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template mswap_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [MswapTheme].
/// {@endtemplate}
class MswapPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro mswap_puzzle_layout_delegate}
  const MswapPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      xlarge: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => MswapStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
          large: 96,
          xlarge: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const MswapPuzzleActionButton(),
          medium: (_, child) => const MswapPuzzleActionButton(),
          large: (_, __) => const SizedBox(),
          xlarge: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const SettingsForm(),
        const ResponsiveGap(
          small: 32,
          medium: 54,
          large: 54,
          xlarge: 54,
        ),
        const StatsBlock(),
        const ResponsiveGap(
          small: 32,
          medium: 54,
          large: 130,
        ),
        const MswapCountdown(),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles, List<Widget> questions) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const MyTimer(),
            xlarge: (_, child) => const MyTimer(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
              xlarge: 96,
            ),
            Stack(
              children: [
                MswapChallengeBoard(questions: questions, size: size),
                MswapPuzzleBoard(tiles: tiles, size: size),
              ],
            ),
            const ResponsiveGap(
              large: 96,
              xlarge: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => MswapPuzzleTile(
        tileFontSize: TileFontSize.small,
        tile: tile,
        state: state,
      ),
      medium: (_, child) => MswapPuzzleTile(
        tileFontSize: TileFontSize.medium,
        tile: tile,
        state: state,
      ),
      large: (_, child) => MswapPuzzleTile(
        tileFontSize: TileFontSize.large,
        tile: tile,
        state: state,
      ),
      xlarge: (_, child) => MswapPuzzleTile(
        tileFontSize: TileFontSize.xlarge,
        tile: tile,
        state: state,
      ),
    );
  }

  @override
  Widget questionBuilder(Question question, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => MswapQuestionTile(
        tileFontSize: QuestionFontSize.small,
        question: question,
      ),
      medium: (_, child) => MswapQuestionTile(
        tileFontSize: QuestionFontSize.medium,
        question: question,
      ),
      large: (_, child) => MswapQuestionTile(
        tileFontSize: QuestionFontSize.large,
        question: question,
      ),
      xlarge: (_, child) => MswapQuestionTile(
        tileFontSize: QuestionFontSize.xlarge,
        question: question,
      ),
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
