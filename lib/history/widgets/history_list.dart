// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);

    final status = context.select((HistoryBloc bloc) => bloc.state.status);

    final leaders = context.select(
      (HistoryBloc bloc) =>
          bloc.state.filteredLeaders(theme: theme.name, settings: settings),
    );

    if (status == HistoryStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status != HistoryStatus.success) {
      return const Center(child: Icon(Icons.broken_image));
    }

    if (leaders.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            context.l10n.tabHistoryEmptyList,
            textAlign: TextAlign.center,
            style: PuzzleTextStyle.settingsLabel.copyWith(
              color: Colors.black54,
            ),
          ),
        ),
      );
    }

    final best = context.select(
      (HistoryBloc bloc) =>
          bloc.state.filteredBest(theme: theme.name, settings: settings),
    );

    return ListTileTheme(
      iconColor: theme.buttonColor,
      textColor: Colors.black54,
      //horizontalTitleGap: 0,
      minVerticalPadding: 4,
      tileColor: theme.defaultColor.withOpacity(0.5),
      child: ListView(
        children: [
          for (final leader in leaders)
            HistoryListTile(
              leader: leader,
              isPB: leader.result == best?.result,
            ),
        ],
      ),
    );
  }
}
