import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';
import 'package:very_good_slide_puzzle/theme/widgets/widgets.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template mswap_score}
/// Displays the score of the solved mswap puzzle.
/// {@endtemplate}
class MswapScore extends StatelessWidget {
  /// {@macro mswap_score}
  const MswapScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((MswapThemeBloc bloc) => bloc.state.theme);
    final state = context.watch<PuzzleBloc>().state;
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      xlarge: (_, child) => child!,
      child: (currentSize) {
        final height =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 355.0;

        final completedTextWidth =
            currentSize == ResponsiveLayoutSize.small ? 160.0 : double.infinity;

        final wellDoneTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4Soft
            : PuzzleTextStyle.headline3;

        final timerTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        final timerIconSize = currentSize == ResponsiveLayoutSize.small
            ? const Size(21, 21)
            : const Size(28, 28);

        final timerIconPadding =
            currentSize == ResponsiveLayoutSize.small ? 4.0 : 6.0;

        final numberOfMovesTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        return ClipRRect(
          key: const Key('mswap_score'),
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: double.infinity,
            height: height,
            color: theme.backgroundColor,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppFlutterLogo(
                              height: 18,
                              isColored: false,
                            ),
                            const ResponsiveGap(
                              small: 24,
                              medium: 32,
                              large: 32,
                              xlarge: 32,
                            ),
                            SizedBox(
                              key: const Key('mswap_score_completed'),
                              width: completedTextWidth,
                              child: AnimatedDefaultTextStyle(
                                style: PuzzleTextStyle.headline5.copyWith(
                                  color: theme.defaultColor,
                                ),
                                duration:
                                    PuzzleThemeAnimationDuration.textStyle,
                                child: Text(l10n.dashatarSuccessCompleted),
                              ),
                            ),
                            const ResponsiveGap(
                              small: 8,
                              medium: 16,
                              large: 16,
                              xlarge: 16,
                            ),
                            AnimatedDefaultTextStyle(
                              key: const Key('mswap_score_well_done'),
                              style: wellDoneTextStyle.copyWith(
                                color: PuzzleColors.white,
                              ),
                              duration: PuzzleThemeAnimationDuration.textStyle,
                              child: Text(l10n.dashatarSuccessWellDone),
                            ),
                            const ResponsiveGap(
                              small: 24,
                              medium: 32,
                              large: 32,
                              xlarge: 32,
                            ),
                            AnimatedDefaultTextStyle(
                              key: const Key('mswap_score_score'),
                              style: PuzzleTextStyle.headline5.copyWith(
                                color: theme.defaultColor,
                              ),
                              duration: PuzzleThemeAnimationDuration.textStyle,
                              child: Text(l10n.dashatarSuccessScore),
                            ),
                            const ResponsiveGap(
                              small: 8,
                              medium: 9,
                              large: 9,
                              xlarge: 9,
                            ),
                            ScoreTimer(
                              textStyle: timerTextStyle,
                              iconSize: timerIconSize,
                              iconPadding: timerIconPadding,
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                            const ResponsiveGap(
                              small: 2,
                              medium: 8,
                              large: 8,
                              xlarge: 8,
                            ),
                            AnimatedDefaultTextStyle(
                              key: const Key('mswap_score_number_of_moves'),
                              style: numberOfMovesTextStyle.copyWith(
                                color: PuzzleColors.white,
                              ),
                              duration: PuzzleThemeAnimationDuration.textStyle,
                              child: Text(
                                l10n.dashatarSuccessNumberOfMoves(
                                  state.numberOfMoves.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            SettingsBlock(
                                key: Key('mswap_score_settings'),),
                            Expanded(
                              child: Center(child: PbBlock()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
