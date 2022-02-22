import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class DashatarStartSection extends StatelessWidget {
  /// {@macro dashatar_start_section}
  const DashatarStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveLayoutBuilder(
          small: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.dashatarIntro,
              extra: context.l10n.dashatarExtra,
            ),
          ),
          medium: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.dashatarIntro,
              extra: context.l10n.dashatarExtra,
            ),
          ),
          large: (_, __) => const SizedBox(),
          xlarge: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 24,
          medium: 40,
          large: 96,
          xlarge: 96,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        const ResponsiveGap(
          large: 16,
          xlarge: 16,
        ),
        PuzzleTitle(
          key: puzzleTitleKey,
          title: context.l10n.dashatarTitle,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
          xlarge: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == DashatarPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
          xlarge: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const DashatarPuzzleActionButton(),
          xlarge: (_, __) => const DashatarPuzzleActionButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const MyTimer(),
          medium: (_, __) => const MyTimer(),
          large: (_, __) => const SizedBox(),
          xlarge: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          large: 42,
          xlarge: 52,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (context, __) => PuzzleIntro(
            intro: context.l10n.dashatarIntro,
            extra: context.l10n.dashatarExtra,
          ),
          xlarge: (_, __) => PuzzleIntro(
            intro: context.l10n.dashatarIntro,
            extra: context.l10n.dashatarExtra,
          ),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
