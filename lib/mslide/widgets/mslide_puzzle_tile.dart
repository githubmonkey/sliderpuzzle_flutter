import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template mslide_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class MslidePuzzleTile extends StatefulWidget {
  /// {@macro mslide_puzzle_tile}
  const MslidePuzzleTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<MslidePuzzleTile> createState() => MslidePuzzleTileState();
}

/// The state of [MslidePuzzleTile].
@visibleForTesting
class MslidePuzzleTileState extends State<MslidePuzzleTile>
    with TickerProviderStateMixin {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  /// The controller that drives [_hoverScale] animation.
  late AnimationController _hoverController;
  late Animation<double> _hoverScale;

  /// The controller that drives [_revealFade] animation for the launch seq.
  late AnimationController _revealController;
  late Animation<double> _revealFade;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _hoverScale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
    _revealController = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.questionLaunch,
    );

    _revealFade = CurvedAnimation(
      parent: _revealController,
      curve: const Interval(0, 1, curve: Curves.easeIn),
    );

    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/tile_move.mp3');
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _revealController.dispose();
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme = context.select((MslideThemeBloc bloc) => bloc.state.theme);
    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);
    final launchStage =
        context.select((MslidePuzzleBloc bloc) => bloc.state.launchStage);
    final hide = status == MslidePuzzleStatus.loading &&
        (launchStage == LaunchStages.resetting ||
            launchStage == LaunchStages.showQuestions);
    final reveal = status == MslidePuzzleStatus.notStarted ||
        status == MslidePuzzleStatus.started ||
        (status == MslidePuzzleStatus.loading &&
            launchStage == LaunchStages.showAnswers);
    final game =
        context.select((SettingsBloc bloc) => bloc.state.settings.game);
    // final withClues =
    //     context.select((SettingsBloc bloc) => bloc.state.settings.withClues);
    final isPaused =
        context.select((MslidePuzzleBloc bloc) => bloc.state.isPaused);

    final hasStarted = status == MslidePuzzleStatus.started;
    final loading = status == MslidePuzzleStatus.loading;

    final puzzleComplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.complete;

    final canPress = hasStarted && !puzzleComplete;

    if (hide) {
      _revealController.reset();
      return const SizedBox();
    } else if (reveal) {
      _revealController.forward();
    }

    final movementDuration = loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    final adjustedFontSize = game == Game.roman || game == Game.binary
        ? widget.tileFontSize / 2
        : widget.tileFontSize;

    final correctPosition = hasStarted &&
        //(puzzleComplete || withClues) &&
        widget.tile.currentPosition == widget.tile.correctPosition;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: FadeTransition(
        opacity: _revealFade,
        child: AnimatedAlign(
          alignment: FractionalOffset(
            (widget.tile.currentPosition.x - 1) / (size - 1),
            (widget.tile.currentPosition.y - 1) / (size - 1),
          ),
          duration: movementDuration,
          curve: Curves.easeInOut,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => SizedBox.square(
              key: Key('mslide_puzzle_tile_small_${widget.tile.value}'),
              dimension: BoardSize.getTileSize(BoardSize.small, size),
              child: child,
            ),
            medium: (_, child) => SizedBox.square(
              key: Key('mslide_puzzle_tile_medium_${widget.tile.value}'),
              dimension: BoardSize.getTileSize(BoardSize.medium, size),
              child: child,
            ),
            large: (_, child) => SizedBox.square(
              key: Key('mslide_puzzle_tile_large_${widget.tile.value}'),
              dimension: BoardSize.getTileSize(BoardSize.large, size),
              child: child,
            ),
            xlarge: (_, child) => SizedBox.square(
              key: Key('mslide_puzzle_tile_xlarge_${widget.tile.value}'),
              dimension: BoardSize.getTileSize(BoardSize.xlarge, size),
              child: child,
            ),
            child: (_) => MouseRegion(
              onEnter: (_) {
                if (canPress) {
                  _hoverController.forward();
                }
              },
              onExit: (_) {
                _hoverController.reverse();
              },
              child: ScaleTransition(
                key: Key('mslide_puzzle_tile_scale_${widget.tile.value}'),
                scale: _hoverScale,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: PuzzleColors.white,
                    textStyle: PuzzleTextStyle.headline2.copyWith(
                      fontSize: adjustedFontSize,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      side: BorderSide(
                        color: correctPosition
                            ? Colors.amberAccent
                            : PuzzleColors.white,
                        width: 4,
                      ),
                    ),
                  ).copyWith(
                    foregroundColor:
                        MaterialStateProperty.all(PuzzleColors.black),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.hovered)) {
                          return theme.hoverColor;
                        } else {
                          return theme.defaultColor.withOpacity(0.5);
                        }
                      },
                    ),
                  ),
                  onPressed: canPress
                      ? () {
                          context
                              .read<PuzzleBloc>()
                              .add(TileTapped(widget.tile));
                          unawaited(_audioPlayer?.replay());
                        }
                      : null,
                  child: AnimatedOpacity(
                    duration: PuzzleThemeAnimationDuration.puzzleTilePause,
                    opacity: isPaused ? 0.02 : 1.0,
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          child: Center(
                            child: Text(
                              getEncodingHelper().encoded(widget.tile.pair),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
