import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 100;
  static double large = 112;
}

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
    with SingleTickerProviderStateMixin {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  /// The controller that drives [_scale] animation.
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.puzzleTileScale,
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
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
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((MslideThemeBloc bloc) => bloc.state.theme);
    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == mslidePuzzleStatus.started;
    final puzzleIncomplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.incomplete;

    final canPress = hasStarted && puzzleIncomplete;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: Key('mslide_puzzle_tile_small_${widget.tile.value}'),
          dimension: _TileSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: Key('mslide_puzzle_tile_medium_${widget.tile.value}'),
          dimension: _TileSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: Key('mslide_puzzle_tile_large_${widget.tile.value}'),
          dimension: _TileSize.large,
          child: child,
        ),
        child: (_) => MouseRegion(
          onEnter: (_) {
            if (canPress) {
              _controller.forward();
            }
          },
          onExit: (_) {
            if (canPress) {
              _controller.reverse();
            }
          },
          child: ScaleTransition(
            key: Key('mslide_puzzle_tile_scale_${widget.tile.value}'),
            scale: _scale,
            child: TextButton(
                style: TextButton.styleFrom(
                  primary: PuzzleColors.white,
                  textStyle: PuzzleTextStyle.headline2.copyWith(
                    fontSize: widget.tileFontSize,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
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
                        context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                        unawaited(_audioPlayer?.replay());
                      }
                    : null,
                child: Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.tile.pair.answer.toString(),
                          semanticsLabel: context.l10n.puzzleTileLabelText(
                            widget.tile.pair.answer.toString(),
                            widget.tile.currentPosition.x.toString(),
                            widget.tile.currentPosition.y.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
