import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template mswap_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class MswapPuzzleBoard extends StatefulWidget {
  /// {@macro mswap_puzzle_board}
  const MswapPuzzleBoard({
    Key? key,
    required this.tiles,
    required this.size,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The board size
  final int size;

  @override
  State<MswapPuzzleBoard> createState() => _MswapPuzzleBoardState();
}

class _MswapPuzzleBoardState extends State<MswapPuzzleBoard> {
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
                    value: context.read<MswapThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<PuzzleBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<HistoryBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AudioControlBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<ThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<SettingsBloc>(),
                  ),
                ],
                child: const MswapShareDialog(),
              ),
            );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          dimension: BoardSize.small,
          key: const Key('mswap_puzzle_board_small'),
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          dimension: BoardSize.medium,
          key: const Key('mswap_puzzle_board_medium'),
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          dimension: BoardSize.large,
          key: const Key('mswap_puzzle_board_large'),
          child: child,
        ),
        xlarge: (_, child) => SizedBox.square(
          dimension: BoardSize.xlarge,
          key: const Key('mswap_puzzle_board_xlarge'),
          child: child,
        ),
        child: (_) => Stack(children: widget.tiles),
      ),
    );
  }
}
