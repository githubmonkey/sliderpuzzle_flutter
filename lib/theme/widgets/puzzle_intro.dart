import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template puzzle_intro}
/// Displays the intro and extra texts in the given color.
/// {@endtemplate}
class PuzzleIntro extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleIntro({
    Key? key,
    required this.intro,
    required this.extra,
    this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String intro;

  /// Extra info
  final String extra;

  /// The color of [intro], defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final textColor = color ?? theme.defaultColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      xlarge: (context, child) => child!,
      child: (currentSize) {

        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: PuzzleTextStyle.body.copyWith(color: textColor),
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Column(
            children: [
              Text(intro, textAlign: textAlign),
              if (extra.isNotEmpty)
                Text(
                  extra,
                  textAlign: textAlign,
                  style: PuzzleTextStyle.label.copyWith(color: textColor),
                )
              else
                const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
