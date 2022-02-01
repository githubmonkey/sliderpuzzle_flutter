import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/bloc/mslide_puzzle_bloc.dart';
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
    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);
    final notStarted = (status == mslidePuzzleStatus.notStarted);
    final hasStarted = (status == mslidePuzzleStatus.started);

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
                      child: notStarted
                          ? SizedBox()
                          : AnimatedOpacity(
                              opacity: (hasStarted ? 1.0 : 0.0),
                              duration: const Duration(milliseconds: 5000),
                              child: Text(
                                question.pair.questionStr,
                                textAlign: TextAlign.center,
                                style: PuzzleTextStyle.headline2.copyWith(
                                    fontSize: tileFontSize,
                                    color: PuzzleColors.grey1),
                                semanticsLabel:
                                    'Question: ${question.pair.questionStr}, index: ${question.index}',
                              ),
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
