import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzle_button.dart';

/// {@template mswap_theme_picker}
/// Displays the mswap theme picker to choose between
/// [MswapThemeState.themes].
///
/// By default allows to choose between [BlueMswapTheme],
/// [GreenMswapTheme] or [YellowMswapTheme].
/// {@endtemplate}
class MswapThemePicker extends StatefulWidget {
  /// {@macro mswap_theme_picker}
  const MswapThemePicker({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  static const _activeThemeNormalSize = 120.0;
  static const _activeThemeSmallSize = 65.0;
  static const _inactiveThemeNormalSize = 96.0;
  static const _inactiveThemeSmallSize = 50.0;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<MswapThemePicker> createState() => _MswapThemePickerState();
}

class _MswapThemePickerState extends State<MswapThemePicker> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<MswapThemeBloc>().state;
    final activeTheme = themeState.theme;

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, child) => child!,
        xlarge: (_, child) => child!,
        child: (currentSize) {
          final isSmallSize = currentSize == ResponsiveLayoutSize.small;
          final activeSize = isSmallSize
              ? MswapThemePicker._activeThemeSmallSize
              : MswapThemePicker._activeThemeNormalSize;
          final inactiveSize = isSmallSize
              ? MswapThemePicker._inactiveThemeSmallSize
              : MswapThemePicker._inactiveThemeNormalSize;

          return SizedBox(
            key: const Key('mswap_theme_picker'),
            height: activeSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                themeState.themes.length,
                (index) {
                  final theme = themeState.themes[index];
                  final isActiveTheme = theme == activeTheme;
                  final padding = index > 0 ? (isSmallSize ? 4.0 : 8.0) : 0.0;
                  final size = isActiveTheme ? activeSize : inactiveSize;

                  return Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: AnimatedContainer(
                      width: size,
                      height: size,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 350),
                      child: PuzzleButton(
                        textColor: PuzzleColors.primary0,
                        backgroundColor: theme.buttonColor,
                        onPressed: () async {
                          if (isActiveTheme) {
                            return;
                          }

                          // Update the current mswap theme.
                          context
                              .read<MswapThemeBloc>()
                              .add(MswapThemeChanged(themeIndex: index));

                          // Play the audio of the current mswap theme.
                          await _audioPlayer.setAsset(theme.audioAsset);
                          unawaited(_audioPlayer.play());
                        },
                        child: Text(theme.name),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
