import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

/// {@template mswap_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class MswapPuzzleActionButton extends StatefulWidget {
  /// {@macro mswap_puzzle_action_button}
  const MswapPuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<MswapPuzzleActionButton> createState() =>
      _MswapPuzzleActionButtonState();
}

class _MswapPuzzleActionButtonState extends State<MswapPuzzleActionButton> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/click.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((MswapThemeBloc bloc) => bloc.state.theme);
    final boardSize =
        context.select((SettingsBloc bloc) => bloc.state.boardSize);
    final elevenToTwenty =
        context.select((SettingsBloc bloc) => bloc.state.elevenToTwenty);

    final status = context.select((MswapPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == mswapPuzzleStatus.loading;
    final isStarted = status == mswapPuzzleStatus.started;

    final text = isStarted
        ? context.l10n.dashatarRestart
        : (isLoading
            ? context.l10n.dashatarGetReady
            : context.l10n.dashatarStartGame);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(status),
          message: isStarted ? context.l10n.puzzleRestartTooltip : '',
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: isLoading
                ? null
                : () async {
                    final hasStarted = status == mswapPuzzleStatus.started;

                    // Reset the timer and the countdown.
                    context.read<TimerBloc>().add(const TimerReset());
                    context.read<MswapPuzzleBloc>().add(
                          MswapCountdownRestart(
                            // TODO(s): does the delay on restart matter?
                            secondsToBegin: hasStarted ? 3 : 3,
                          ),
                        );

                    // Initialize the puzzle board to show the initial puzzle
                    // (unshuffled) before the countdown completes.
                    if (hasStarted) {
                      context.read<PuzzleBloc>().add(
                            PuzzleInitialized(
                              size: boardSize,
                              elevenToTwenty: elevenToTwenty,
                            ),
                          );
                    }

                    unawaited(_audioPlayer.replay());
                  },
            textColor: isLoading ? theme.defaultColor : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}