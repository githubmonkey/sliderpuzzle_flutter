// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/leaderboard/leaderboard.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class FSLeaderboard extends StatelessWidget {
  const FSLeaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state);

    final isAuthenticated = context.select(
        (LoginBloc bloc) => bloc.state.status == LoginStatus.authenticated,);
    final userid = context.select((LoginBloc bloc) => bloc.state.user.id);

    if (!isAuthenticated || userid.isEmpty) {
      return const SizedBox();
    }

    final repo = context.read<FirestoreRepository>();
    final leaders = repo.getHistory(userid, null);

    return AnimatedDefaultTextStyle(
      key: const Key('mslide_score_number_of_moves'),
      style: PuzzleTextStyle.settingsLabel.copyWith(
        color: Colors.black54,
      ),
      duration: PuzzleThemeAnimationDuration.textStyle,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox(
          width: BoardSize.small,
          height: BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox(
          width: BoardSize.medium,
          height: BoardSize.medium,
          child: child,
        ),
        large: (_, child) => Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 420,
            minHeight: 100,
            maxHeight: 420,
          ),
          padding: const EdgeInsets.only(left: 50, right: 32),
          child: child,
        ),
        xlarge: (_, child) => Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 420,
            minHeight: 100,
            maxHeight: 420,
          ),
          padding: const EdgeInsets.only(left: 50, right: 32),
          child: child,
        ),
        child: (currentSize) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: PuzzleColors.grey5),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: PuzzleColors.grey4,
            ),
            child: StreamBuilder<QuerySnapshot<Leader>>(
              stream: leaders,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return LeaderboardListTile(
                      leader: data.docs[index].data(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
