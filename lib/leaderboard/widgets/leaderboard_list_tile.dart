// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    Key? key,
    required this.leader,
    required this.pos,
    required this.isOwn,
    required this.isPB,
  }) : super(key: key);

  final Leader leader;

  final int pos;

  final bool isOwn;

  final bool isPB;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final languageCode = Localizations.localeOf(context).languageCode;
    final format = DateFormat.yMMMEd(languageCode).add_Hm();

    return ListTile(
      tileColor: isOwn ? theme.defaultColor.withOpacity(0.8) : null,
      leading: isPB ? const Icon(Icons.star) : const SizedBox(),
      trailing: Text(pos.toString()),
      title: Text(
        context.l10n.puzzleResultSummary(
          _formatDuration(),
          leader.result.moves.toString(),
          leader.nickname,
        ),
      ),
      subtitle: Text(
        format.format(leader.timestamp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _formatDuration() {
    final duration = Duration(seconds: leader.result.time);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
