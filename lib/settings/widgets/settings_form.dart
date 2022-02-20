import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// Complete settings block
class SettingsForm extends StatelessWidget {
  /// Constructor
  const SettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final settings = context.select((SettingsBloc bloc) => bloc.state.settings);

    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox(
        width: BoardSize.small,
        child: child,
      ),
      medium: (_, child) => SizedBox(
        width: BoardSize.medium,
        child: child,
      ),
      large: (_, child) => Container(
        constraints: const BoxConstraints(minWidth: 150, maxWidth: 420),
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      xlarge: (_, child) => Container(
        constraints: const BoxConstraints(minWidth: 150, maxWidth: 420),
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (currentSize) {
        return ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.settingsLabelBoardSize,
                  style: PuzzleTextStyle.settingsLabel.copyWith(
                    color: theme.defaultColor,
                  ),
                ),
                Slider(
                  value: settings.boardSize.toDouble(),
                  min: 2,
                  max: 5,
                  divisions: 3,
                  activeColor: theme.defaultColor,
                  label: settings.boardSize.toString(),
                  onChanged: (double value) => context.read<SettingsBloc>().add(
                        SettingsChanged(
                          settings: settings.copyWith(boardSize: value.toInt()),
                        ),
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.settingsLabelGame,
                  style: PuzzleTextStyle.settingsLabel.copyWith(
                    color: theme.defaultColor,
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: theme.buttonColor,
                  ),
                  child: DropdownButton<Game>(
                    value: settings.game,
                    alignment: AlignmentDirectional.centerEnd,
                    style: PuzzleTextStyle.settingsLabel.copyWith(
                      color: theme.defaultColor,
                      //backgroundColor: theme.buttonColor,
                    ),
                    onChanged: (Game? result) {
                      if (null != result) {
                        context.read<SettingsBloc>().add(
                              SettingsChanged(
                                settings: settings.copyWith(game: result),
                              ),
                            );
                      }
                    },
                    items: [
                      DropdownMenuItem<Game>(
                        value: Game.multi,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(context.l10n.settingsGameValueMulti),
                      ),
                      DropdownMenuItem<Game>(
                        value: Game.addition,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsGameValueAddition,
                        ),
                      ),
                      DropdownMenuItem<Game>(
                        value: Game.roman,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsGameValueRoman,
                        ),
                      ),
                      DropdownMenuItem<Game>(
                        value: Game.hex,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(context.l10n.settingsGameValueHex),
                      ),
                      DropdownMenuItem<Game>(
                        value: Game.binary,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsGameValueBinary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.settingsLabelElevenToTwenty,
                  style: PuzzleTextStyle.settingsLabel.copyWith(
                    color: theme.defaultColor,
                  ),
                ),
                Switch(
                  value: settings.elevenToTwenty,
                  activeColor: theme.defaultColor,
                  onChanged: (bool value) => context.read<SettingsBloc>().add(
                        SettingsChanged(
                            settings: settings.copyWith(elevenToTwenty: value)),
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
