import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template timer}
/// Displays how many seconds elapsed since starting the puzzle.
/// {@endtemplate}
class MyTimer extends StatelessWidget {
  /// {@macro timer}
  const MyTimer({
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
    final secondsElapsed =
        context.select((TimerBloc bloc) => bloc.state.secondsElapsed);

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

        final timeElapsed = Duration(seconds: secondsElapsed);

        return Row(
          key: const Key('timer'),
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: currentTextStyle.copyWith(
                color: PuzzleColors.white,
              ),
              duration: PuzzleThemeAnimationDuration.textStyle,
              child: Text(
                LocalizationHelper().formatDuration(timeElapsed),
                key: ValueKey(secondsElapsed),
                semanticsLabel: LocalizationHelper()
                    .localizedDurationLabel(context, timeElapsed),
              ),
            ),
            Gap(iconPadding ?? 8),
            Image.asset(
              'assets/images/timer_icon.png',
              key: const Key('timer_icon'),
              width: currentIconSize.width,
              height: currentIconSize.height,
            ),
          ],
        );
      },
    );
  }
}
