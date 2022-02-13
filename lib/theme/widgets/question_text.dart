import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({Key? key, required this.pair, required this.tileFontSize})
      : super(key: key);

  /// The pair that makes up this question
  final Pair pair;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  Widget build(BuildContext context) {
    final encoding =
    context.select((SettingsBloc bloc) => bloc.state.answerEncoding);

    final adjustedFontSize =
    encoding == AnswerEncoding.roman || encoding == AnswerEncoding.binary
        ? tileFontSize * 0.7
        : tileFontSize;

    final style = PuzzleTextStyle.headline2.copyWith(
      fontSize: adjustedFontSize,
      color: PuzzleColors.grey1,
    );

    if (encoding == AnswerEncoding.multi ||
        encoding == AnswerEncoding.addition) {
      return RichText(
        text: TextSpan(
          text: pair.left.toString(),
          style: style,
          children: <InlineSpan>[
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                encoding == AnswerEncoding.multi ? ' x ' : ' + ',
                style: PuzzleTextStyle.label,
              ),
            ),
            TextSpan(
              text: pair.right.toString(),
              style: style,
            ),
          ],
        ),
      );
    } else {
      return Text(pair.answer.toString(), style: style);
    }
  }
}
