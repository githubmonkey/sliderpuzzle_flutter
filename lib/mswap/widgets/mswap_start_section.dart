import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template mswap_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class MswapStartSection extends StatelessWidget {
  /// {@macro mswap_start_section}
  const MswapStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status = context.select((MswapPuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveLayoutBuilder(
          small: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.mswapIntro,
              extra: context.l10n.mswapExtra,
            ),
          ),
          medium: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.mswapIntro,
              extra: context.l10n.mswapExtra,
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
        PuzzleName(key: puzzleNameKey),
        const ResponsiveGap(
          large: 16,
          xlarge: 16,
        ),
        PuzzleTitle(
          key: puzzleTitleKey,
          title: context.l10n.mswapTitle,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
          xlarge: 42,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: status == mswapPuzzleStatus.started
              ? state.numberOfTilesLeft
              : state.puzzle.tiles.length - 1,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
          xlarge: 42,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const MswapPuzzleActionButton(),
          xlarge: (_, __) => const MswapPuzzleActionButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const MswapTimer(),
          medium: (_, __) => const MswapTimer(),
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
            intro: context.l10n.mswapIntro,
            extra: context.l10n.mswapExtra,
          ),
          xlarge: (_, __) => PuzzleIntro(
            intro: context.l10n.mswapIntro,
            extra: context.l10n.mswapExtra,
          ),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
