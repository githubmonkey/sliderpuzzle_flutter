// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class SettingsBlock extends StatelessWidget {
  const SettingsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);
    final nickname = context.select((LoginBloc bloc) => bloc.state.nickname);

    return ResponsiveLayoutBuilder(
      small: (_, child) => Container(
        //width: SettingsBlockSize.small,
        child: child,
      ),
      medium: (_, child) => Container(
        //width: SettingsBlockSize.medium,
        child: child,
      ),
      large: (_, child) => Container(
        //constraints: const BoxConstraints(minWidth: 150, maxWidth: 420),
        //padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      xlarge: (_, child) => Container(
        //constraints: const BoxConstraints(minWidth: 150, maxWidth: 420),
        //padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (currentSize) {
        final valueTextStyle = PuzzleTextStyle.headline5.copyWith(
          color: PuzzleColors.white,
        );

        return AnimatedDefaultTextStyle(
          key: const Key('mslide_score_settings'),
          style: valueTextStyle,
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Column(
            children: [
              const ResponsiveGap(
                small: 42,
                medium: 50,
                large: 50,
                xlarge: 50,
              ),
              Text(
                context.l10n.settingsLabelCaption,
                style: PuzzleTextStyle.headline5.copyWith(
                  color: theme.defaultColor,
                ),
              ),
              const ResponsiveGap(
                small: 8,
                medium: 9,
                large: 9,
                xlarge: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.settingsLabelTheme),
                  Text(theme.name),
                ],
              ),
              const ResponsiveGap(
                small: 8,
                medium: 9,
                large: 9,
                xlarge: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.settingsLabelBoardSize),
                  Text(settings.boardSize.toString()),
                ],
              ),
              const ResponsiveGap(
                small: 8,
                medium: 9,
                large: 9,
                xlarge: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.settingsLabelGame),
                  Text(LocalizationHelper().localizedGame(
                    context,
                    settings.game,
                  ),),
                ],
              ),
              const ResponsiveGap(
                small: 8,
                medium: 9,
                large: 9,
                xlarge: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.settingsLabelElevenToTwenty),
                  Text(
                    LocalizationHelper().localizedElevenToTwenty(
                      context,
                      settings.elevenToTwenty,
                    ),
                  ),
                ],
              ),
              const ResponsiveGap(
                small: 8,
                medium: 9,
                large: 9,
                xlarge: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.settingsLabelNickname),
                  Text(nickname),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
