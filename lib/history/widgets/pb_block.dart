// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class PbBlock extends StatelessWidget {
  const PbBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);
    final userid = context.select((LoginBloc bloc) => bloc.state.user.id);

    final current = context.select(
      (HistoryBloc bloc) => bloc.state
          .filteredLeaders(
            userid: userid,
            theme: theme.name,
            settings: settings,
          )
          .first,
    );

    final best = context.select(
      (HistoryBloc bloc) => bloc.state.filteredBest(
        userid: userid,
        theme: theme.name,
        settings: settings,
      ),
    );

    final textStyle =
        PuzzleTextStyle.headline5.copyWith(color: theme.defaultColor);

    if (best == null ||
        current == best ||
        current.result.compareTo(best.result) == -1) {
      return Text(
        context.l10n.dashatarSuccessNewPB,
        style: textStyle.copyWith(color: theme.defaultColor),
      );
    } else {
      // TODO(s): add sprinkles
      return Text(
        context.l10n.dashatarSuccessPastPB(
          LocalizationHelper().formatDuration(best.result.timeAsDuration),
        ),
        style: textStyle.copyWith(color: theme.defaultColor),
      );
    }
  }
}
