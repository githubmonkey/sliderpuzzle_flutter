
import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

/// {@template mslide_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class MslideQuestionTile extends StatelessWidget {
  /// {@macro mslide_puzzle_tile}
  const MslideQuestionTile({
    Key? key,
    required this.question,
    required this.tileFontSize,
  });

  /// The tile to be displayed.
  final Question question;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      key: Key('mslide_question_${question.index}'),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: PuzzleColors.white,
          border: Border.all(
            color: PuzzleColors.grey2,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: question.isWhitespace
            ? SizedBox()
            : Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        question.questionStr,
                        textAlign: TextAlign.center,
                        style: PuzzleTextStyle.headline2.copyWith(
                            fontSize: tileFontSize, color: PuzzleColors.grey1),
                        semanticsLabel:
                            'Question: ${question.questionStr}, index: ${question.index}',
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
      ),
    );
  }
}
