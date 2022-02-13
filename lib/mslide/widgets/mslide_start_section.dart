import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template mslide_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class MslideStartSection extends StatelessWidget {
  /// {@macro mslide_start_section}
  const MslideStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveLayoutBuilder(
          small: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.mslideIntro,
              extra: context.l10n.mslideExtra,
            ),
          ),
          medium: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PuzzleIntro(
              intro: context.l10n.mslideIntro,
              extra: context.l10n.mslideExtra,
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
          title: context.l10n.mslideTitle,
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
          numberOfTilesLeft: status == mslidePuzzleStatus.started
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
          large: (_, __) => const MslidePuzzleActionButton(),
          xlarge: (_, __) => const MslidePuzzleActionButton(),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const MslideTimer(),
          medium: (_, __) => const MslideTimer(),
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
            intro: context.l10n.mslideIntro,
            extra: context.l10n.mslideExtra,
          ),
          xlarge: (_, __) => PuzzleIntro(
            intro: context.l10n.mslideIntro,
            extra: context.l10n.mslideExtra,
          ),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
