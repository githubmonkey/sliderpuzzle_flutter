import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final boardSize =
        context.select((SettingsBloc bloc) => bloc.state.boardSize);
    final elevenToTwenty =
        context.select((SettingsBloc bloc) => bloc.state.elevenToTwenty);
    final answerEncoding =
        context.select((SettingsBloc bloc) => bloc.state.answerEncoding);

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
                  value: boardSize.toDouble(),
                  min: 2,
                  max: 5,
                  divisions: 3,
                  activeColor: theme.defaultColor,
                  label: boardSize.toString(),
                  onChanged: (double value) => context
                      .read<SettingsBloc>()
                      .add(BoardSizeChanged(boardSize: value.toInt())),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.settingsLabelAnswerEncoding,
                  style: PuzzleTextStyle.settingsLabel.copyWith(
                    color: theme.defaultColor,
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: theme.buttonColor,
                  ),
                  child: DropdownButton<AnswerEncoding>(
                    value: answerEncoding,
                    alignment: AlignmentDirectional.centerEnd,
                    style: PuzzleTextStyle.settingsLabel.copyWith(
                      color: theme.defaultColor,
                      //backgroundColor: theme.buttonColor,
                    ),
                    onChanged: (AnswerEncoding? result) {
                      if (null != result) {
                        context.read<SettingsBloc>().add(
                              AnswerEncodingChanged(answerEncoding: result),
                            );
                      }
                    },
                    items: [
                      DropdownMenuItem<AnswerEncoding>(
                        value: AnswerEncoding.multi,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsAnswerEncodingValueMulti,
                        ),
                      ),
                      DropdownMenuItem<AnswerEncoding>(
                        value: AnswerEncoding.addition,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsAnswerEncodingValueAddition,
                        ),
                      ),
                      DropdownMenuItem<AnswerEncoding>(
                        value: AnswerEncoding.roman,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsAnswerEncodingValueRoman,
                        ),
                      ),
                      DropdownMenuItem<AnswerEncoding>(
                        value: AnswerEncoding.hex,
                        alignment: AlignmentDirectional.centerEnd,
                        child:
                            Text(context.l10n.settingsAnswerEncodingValueHex),
                      ),
                      DropdownMenuItem<AnswerEncoding>(
                        value: AnswerEncoding.binary,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          context.l10n.settingsAnswerEncodingValueBinary,
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
                  value: elevenToTwenty,
                  activeColor: theme.defaultColor,
                  onChanged: (bool value) => context
                      .read<SettingsBloc>()
                      .add(ElevenToTwentyChanged(elevenToTwenty: value)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
