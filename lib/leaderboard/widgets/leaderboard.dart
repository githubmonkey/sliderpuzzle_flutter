// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/leaderboard/leaderboard.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    // final boardSize =
    //     context.select((SettingsBloc bloc) => bloc.state.boardSize);
    // final elevenToTwenty =
    //     context.select((SettingsBloc bloc) => bloc.state.elevenToTwenty);
    // final answerEncoding =
    //     context.select((SettingsBloc bloc) => bloc.state.answerEncoding);

    final status = context.select((LeaderboardBloc bloc) => bloc.state.status);
    final leaders =
        context.select((LeaderboardBloc bloc) => bloc.state.leaders);

    return AnimatedDefaultTextStyle(
      key: const Key('mslide_score_number_of_moves'),
      style: PuzzleTextStyle.settingsLabel.copyWith(
        color: theme.defaultColor,
      ),
      duration: PuzzleThemeAnimationDuration.textStyle,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox(
          width: BoardSize.small,
          height: BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox(
          width: BoardSize.medium,
          height: BoardSize.medium,
          child: child,
        ),
        large: (_, child) => Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 420,
            minHeight: 100,
            maxHeight: 420,
          ),
          padding: const EdgeInsets.only(left: 50, right: 32),
          child: child,
        ),
        xlarge: (_, child) => Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 420,
            minHeight: 100,
            maxHeight: 420,
          ),
          padding: const EdgeInsets.only(left: 50, right: 32),
          child: child,
        ),
        child: (currentSize) {
          if (status == LeaderboardStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (status != LeaderboardStatus.success) {
            return const Center(child: Icon(Icons.broken_image));
          } else if (leaders.isEmpty) {
            return const Center(
              child: Text('no entries for these settings yet'),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: PuzzleColors.grey5),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: PuzzleColors.grey4,
              ),
              child: ListTileTheme(
                tileColor: Colors.green,
                textColor: Colors.black54,
                horizontalTitleGap: 100,
                child: ListView(
                  children: [
                    for (final leader in leaders)
                      LeaderboardListTile(leader: leader),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
