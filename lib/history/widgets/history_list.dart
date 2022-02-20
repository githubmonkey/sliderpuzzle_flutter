// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/history/history.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final status = context.select((HistoryBloc bloc) => bloc.state.status);

    final leaders = context.select((HistoryBloc bloc) => bloc.state.leaders);
    List<Leader> sortable = List<Leader>.from(leaders);
    // TODO: add second criteria
    sortable.sort((a, b) => a.time.compareTo(b.time));

    if (status == HistoryStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (status != HistoryStatus.success) {
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
              for (final leader in sortable)
                HistoryListTile(
                  leader: leader,
                  isPB: false,
                ),
            ],
          ),
        ),
      );
    }
  }
}
