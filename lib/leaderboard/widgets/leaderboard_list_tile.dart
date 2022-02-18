// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:leaders_repository/leaders_repository.dart';

class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    Key? key,
    required this.leader,
  }) : super(key: key);

  final Leader leader;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.caption?.color;

    return ListTile(
      title: Text(
        leader.userid,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: captionColor,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      subtitle: Text(
        '${leader.time}, ${leader.moves}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
