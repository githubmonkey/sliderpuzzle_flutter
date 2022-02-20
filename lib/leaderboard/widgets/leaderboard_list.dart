// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/leaderboard/leaderboard.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);

    final isAuthenticated = context.select(
      (LoginBloc bloc) => bloc.state.status == LoginStatus.authenticated,
    );
    final userid = context.select((LoginBloc bloc) => bloc.state.user.id);

    if (!isAuthenticated || userid.isEmpty) {
      return const SizedBox();
    }

    final repo = context.read<FirestoreRepository>();
    final leaders =
        repo.getLeaders(userid, theme: theme.name, settings: settings);

    return AnimatedDefaultTextStyle(
      key: const Key('mslide_score_number_of_moves'),
      style: PuzzleTextStyle.settingsLabel.copyWith(
        color: Colors.black54,
      ),
      duration: PuzzleThemeAnimationDuration.textStyle,
      child: StreamBuilder<QuerySnapshot<Leader>>(
        stream: leaders,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          if (data.size == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  context.l10n.tabEmptyList,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // get index of best
          // TODO(s): move this somewhere more appropriately
          var best = 0;
          for (var i = 0; i < data.docs.length; i++) {
            var current = data.docs[i].data();
            var prev = data.docs[best].data();
            if (current.time < prev.time ||
                (current.time == prev.time && current.moves < prev.moves)) {
              best = i;
            }
          }

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              final item = data.docs[index].data();
              return LeaderboardListTile(
                key: Key('leader_${item.id}'),
                leader: item,
                isPB: index == best,
              );
            },
          );
        },
      ),
    );
  }
}
