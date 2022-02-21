// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    Key? key,
    required this.leader,
    required this.pos,
  }) : super(key: key);

  final Leader leader;

  final int pos;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final format = DateFormat.yMMMEd(languageCode).add_Hm();

    return ListTile(
      leading: Text(pos.toString()),
      title: Text(
        context.l10n
            .puzzleResultSummary(_formatDuration(), leader.result.moves.toString()),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
      dense: false,
      subtitle: Text(
        '${leader.userid}\n${format.format(leader.timestamp)}',
        maxLines: 2,
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
