// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/leaderboard/widgets/fs_leaderboard.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class StatsBlock extends StatelessWidget {
  const StatsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);

    return ResponsiveLayoutBuilder(
        small: (context, child) => SizedBox(
              width: BoardSize.small,
              height: BoardSize.small,
              child: child,
            ),
        medium: (context, child) => SizedBox(
              width: BoardSize.medium,
              height: BoardSize.medium,
              child: child,
            ),
        large: (context, child) => Container(
              width: 420,
              height: 282,
              padding: const EdgeInsets.only(left: 50, right: 32),
              child: child,
            ),
        xlarge: (context, child) => Container(
              width: 420,
              height: 410,
              padding: const EdgeInsets.only(left: 50, right: 32),
              child: child,
            ),
        child: (_) {
          return DefaultTabController(
            length: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: theme.buttonColor,
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TabBar(
                        indicatorColor: theme.menuUnderlineColor,
                        unselectedLabelColor: theme.defaultColor,
                        labelStyle: PuzzleTextStyle.settingsLabel.copyWith(
                          color: theme.defaultColor,
                        ),
                        tabs: [
                          Tab(
                            text: context.l10n.tabLabelHistory,
                          ),
                          Tab(
                            text: context.l10n.tabLabelLeaderboard,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    const FSLeaderboard(),
                    const FSLeaderboard(),
                  ],
                ),
              ),
            ),
          );
        });
  }

//         Column(
//           children: [
//             Text('heading'),
//             Expanded(child: FSLeaderboard()),
//             Text('footer')
//           ],
//         ),
//       );
//     },
//   );
// }
}
