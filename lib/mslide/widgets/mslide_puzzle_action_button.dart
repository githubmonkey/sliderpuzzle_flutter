import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template mslide_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class MslidePuzzleActionButton extends StatefulWidget {
  /// {@macro mslide_puzzle_action_button}
  const MslidePuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<MslidePuzzleActionButton> createState() =>
      _MslidePuzzleActionButtonState();
}

class _MslidePuzzleActionButtonState extends State<MslidePuzzleActionButton> {
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
    final theme = context.select((MslideThemeBloc bloc) => bloc.state.theme);

    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == MslidePuzzleStatus.loading;
    final isStarted = status == MslidePuzzleStatus.started;

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
                : isStarted
                    ? onRestart
                    : onInitialStart,
            textColor: isLoading ? theme.defaultColor : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }

  /// Called when starting countdown for the first time.
  void onInitialStart() {
    context.read<TimerBloc>().add(const TimerReset());
    context.read<MslidePuzzleBloc>().add(
          MslideCountdownRestart(secondsToBegin: 3),
        );
    unawaited(_audioPlayer.replay());
  }

  /// Called when requesting a restart/pause
  void onRestart() async {
    final theme = context.read<MslideThemeBloc>().state.theme;

    // Stop the timer and the countdown for now.
    context.read<TimerBloc>().add(const TimerStopped());
    context.read<MslidePuzzleBloc>().add(MslidePuzzlePaused());

    unawaited(_audioPlayer.replay());

    await showAlertDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: theme.backgroundColor.withAlpha(0xfa),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<MslideThemeBloc>(),
          ),
          BlocProvider.value(
            value: context.read<PuzzleBloc>(),
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
        child: AlertDialog(
          title: Text(context.l10n.restartDialogTitle),
          titleTextStyle: PuzzleTextStyle.headline4,
          content: Text(context.l10n.restartDialogContent),
          contentTextStyle: PuzzleTextStyle.bodySmall,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: theme.buttonColor,
                textStyle: PuzzleTextStyle.actionLabel,
              ),
              child: Text(context.l10n.restartDialogNo),
              onPressed: () {
                // Resume the timer
                context.read<TimerBloc>().add(const TimerResumed());
                context.read<MslidePuzzleBloc>().add(MslidePuzzleResumed());
                unawaited(_audioPlayer.replay());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(context.l10n.restartDialogYes),
              style: TextButton.styleFrom(
                primary: theme.buttonColor,
                textStyle: PuzzleTextStyle.actionLabel,
              ),
              onPressed: () {
                // Reset the timer and the countdown.
                context.read<TimerBloc>().add(const TimerReset());
                context.read<MslidePuzzleBloc>().add(
                      MslideCountdownRestart(secondsToBegin: 3),
                    );

                // Initialize the puzzle board to show the initial puzzle
                // (unshuffled) before the countdown completes.
                final settings = context.read<SettingsBloc>().state.settings;
                context
                    .read<PuzzleBloc>()
                    .add(PuzzleInitialized(settings: settings));

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
