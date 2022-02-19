// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaders_repository/leaders_repository.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    Key? key,
    required this.leader,
  }) : super(key: key);

  final Leader leader;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final format = DateFormat.yMMMEd(languageCode).add_Hm();

    return ListTile(
      title: Text(
        '${_formatDuration()}, ${_formatMoves(context)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        format.format(leader.timestamp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _formatDuration() {
    final duration = Duration(seconds: leader.time);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String _formatMoves(BuildContext context) {
    return context.l10n.dashatarSuccessNumberOfMoves(leader.moves.toString());
  }
}
