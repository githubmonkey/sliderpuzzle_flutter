// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/leaderboard/bloc/leaderboard_bloc.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state.leaders.isEmpty) {
          if (state.status == LeaderboardStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status != LeaderboardStatus.success) {
            return const Center(child: Icon(Icons.broken_image));
          } else {
            return Center(
              child: Text(
                'no entries yet',
                style: Theme.of(context).textTheme.caption,
              ),
            );
          }
        }

        return const Center(child: Text('something here'));
        // TODO(s): Dimensions like dashatar image
        // return ListView(
        //   children: [
        //     for (final leader in state.filteredLeaders)
        //       LeaderboardListTile(
        //         leader: leader,
        //       ),
        //   ],
        // );
      },
    );
  }
}
