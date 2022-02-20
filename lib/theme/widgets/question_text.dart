import 'package:flutter/material.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:provider/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

/// The top part of a tile
class QuestionText extends StatelessWidget {
  /// Constructor
  const QuestionText({Key? key, required this.pair, required this.tileFontSize})
      : super(key: key);

  /// The pair that makes up this question
  final Pair pair;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  Widget build(BuildContext context) {
    final game =
        context.select((SettingsBloc bloc) => bloc.state.settings.game);

    final adjustedFontSize =
        game == Game.roman || game == Game.binary
            ? tileFontSize * 0.7
            : tileFontSize;

    final style = PuzzleTextStyle.headline2.copyWith(
      fontSize: adjustedFontSize,
      color: PuzzleColors.grey1,
    );

    if (game == Game.multi ||
        game == Game.addition) {
      return RichText(
        text: TextSpan(
          text: pair.left.toString(),
          style: style,
          children: <InlineSpan>[
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                game == Game.multi ? ' x ' : ' + ',
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
