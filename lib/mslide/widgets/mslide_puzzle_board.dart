import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/puzzle/widgets/puzzle_grid.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template mslide_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class MslidePuzzleBoard extends StatefulWidget {
  /// {@macro mslide_puzzle_board}
  const MslidePuzzleBoard({
    Key? key,
    required this.tiles,
    required this.size,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The board size
  final int size;

  @override
  State<MslidePuzzleBoard> createState() => _MslidePuzzleBoardState();
}

class _MslidePuzzleBoardState extends State<MslidePuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    _completePuzzleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          _completePuzzleTimer =
              Timer(const Duration(milliseconds: 370), () async {
            await showAppDialog<void>(
              context: context,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<MslideThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<PuzzleBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<TimerBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AudioControlBloc>(),
                  ),
                ],
                child: const MslideShareDialog(),
              ),
            );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          dimension: _BoardSize.small,
          child: PuzzleGrid(
            key: const Key('mslide_puzzle_board_small'),
            size: widget.size,
            tiles: widget.tiles,
          ),
        ),
        medium: (_, child) => SizedBox.square(
          dimension: _BoardSize.medium,
          child: PuzzleGrid(
            key: const Key('mslide_puzzle_board_medium'),
            size: widget.size,
            tiles: widget.tiles,
          ),
        ),
        large: (_, child) => SizedBox.square(
          dimension: _BoardSize.large,
          child: PuzzleGrid(
            key: const Key('mslide_puzzle_board_large'),
            size: widget.size,
            tiles: widget.tiles,
          ),
        ),
      ),
    );
  }
}
