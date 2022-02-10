import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final boardSize =
        context.select((SettingsBloc bloc) => bloc.state.boardSize);
    final elevenToTwenty =
        context.select((SettingsBloc bloc) => bloc.state.elevenToTwenty);
    final answerEncoding =
        context.select((SettingsBloc bloc) => bloc.state.answerEncoding);

    return SizedBox(
      width: 300,
      height: 400,
      child: ListView(
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
                max: 6,
                divisions: 4,
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
                  style: PuzzleTextStyle.settingsLabel.copyWith(
                    color: theme.defaultColor,
                    //backgroundColor: theme.buttonColor,
                  ),
                  onChanged: (AnswerEncoding? result) {
                    if (null != result) {
                      context
                          .read<SettingsBloc>()
                          .add(AnswerEncodingChanged(answerEncoding: result));
                    }
                  },
                  items: [
                    DropdownMenuItem<AnswerEncoding>(
                      value: AnswerEncoding.decimal,
                      child: Text(
                        context.l10n.settingsAnswerEncodingValueDecimal,
                      ),
                    ),
                    DropdownMenuItem<AnswerEncoding>(
                      value: AnswerEncoding.roman,
                      child: Text(context.l10n.settingsAnswerEncodingValueRoman),
                    ),
                    DropdownMenuItem<AnswerEncoding>(
                      value: AnswerEncoding.hex,
                      child: Text(context.l10n.settingsAnswerEncodingValueHex),
                    ),
                    DropdownMenuItem<AnswerEncoding>(
                      value: AnswerEncoding.binary,
                      child: Text(context.l10n.settingsAnswerEncodingValueBinary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
