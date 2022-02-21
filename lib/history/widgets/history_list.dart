// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);

    final status = context.select((HistoryBloc bloc) => bloc.state.status);

    final leaders = context.select((HistoryBloc bloc) =>
        bloc.state.filteredLeaders(theme: theme.name, settings: settings));

    if (status == HistoryStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (status != HistoryStatus.success) {
      return const Center(child: Icon(Icons.broken_image));
    } else if (leaders.isEmpty) {
      return const Center(
        child: Text('no entries for these settings yet'),
      );
    } else {
      final best = _getMin(leaders);

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: PuzzleColors.grey5),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: PuzzleColors.grey4,
        ),
        child: ListTileTheme(
          iconColor: theme.buttonColor,
          textColor: Colors.black54,
          horizontalTitleGap: 0,
          child: ListView(
            children: [
              for (final leader in leaders)
                HistoryListTile(
                  leader: leader,
                  isPB: leader.time == best.time && leader.moves == best.moves,
                ),
            ],
          ),
        ),
      );
    }
  }
}

// TODO(s): move to leaders and unit test
Leader _getMin(Iterable<Leader> leaders) {
  return leaders.reduce((value, element) => (value.time < element.time ||
          (value.time == element.time && value.moves < element.moves)
      ? value
      : element));
}
