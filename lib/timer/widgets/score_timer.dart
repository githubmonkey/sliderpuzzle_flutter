import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/localization_helper.dart';
import 'package:very_good_slide_puzzle/history/bloc/history_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template score_timer}
/// Displays how many seconds elapsed since starting the puzzle.
///
/// Warning: for now there are two variants, this one historybloc based
/// and MslideTimer as timerbloc based
/// {@endtemplate}
class ScoreTimer extends StatelessWidget {
  /// {@macro score_timer}
  const ScoreTimer({
    Key? key,
    this.textStyle,
    this.iconSize,
    this.iconPadding,
    this.mainAxisAlignment,
  }) : super(key: key);

  /// The optional [TextStyle] of this timer.
  final TextStyle? textStyle;

  /// The optional icon [Size] of this timer.
  final Size? iconSize;

  /// The optional icon padding of this timer.
  final double? iconPadding;

  /// The optional [MainAxisAlignment] of this timer.
  /// Defaults to [MainAxisAlignment.center] if not provided.
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);
    final current = context.select(
      (HistoryBloc bloc) => bloc.state
          .filteredLeaders(theme: theme.name, settings: settings)
          .first,
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      xlarge: (_, child) => child!,
      child: (currentSize) {
        final currentTextStyle = textStyle ??
            (currentSize == ResponsiveLayoutSize.small
                ? PuzzleTextStyle.headline4
                : PuzzleTextStyle.headline3);

        final currentIconSize = iconSize ??
            (currentSize == ResponsiveLayoutSize.small
                ? const Size(28, 28)
                : const Size(32, 32));

        return Row(
          key: const Key('my_timer'),
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: currentTextStyle.copyWith(
                color: PuzzleColors.white,
              ),
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                LocalizationHelper().formatDuration(
                  current.result.timeAsDuration,
                ),
                key: ValueKey(current.result.time),
                semanticsLabel: LocalizationHelper().localizedDurationLabel(
                  context,
                  current.result.timeAsDuration,
                ),
              ),
            ),
            Gap(iconPadding ?? 8),
            Image.asset(
              'assets/images/timer_icon.png',
              key: const Key('my_timer_icon'),
              width: currentIconSize.width,
              height: currentIconSize.height,
            ),
          ],
        );
      },
    );
  }
}
