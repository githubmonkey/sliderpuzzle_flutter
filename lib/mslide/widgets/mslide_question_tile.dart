import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/bloc/mslide_puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/theme/themes/puzzle_theme_animations.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

/// {@template mslide_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class MslideQuestionTile extends StatefulWidget {
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
  State<MslideQuestionTile> createState() => _MslideQuestionTileState();
}

/// The state of [MslideQuestionTile].
@visibleForTesting
class _MslideQuestionTileState extends State<MslideQuestionTile>
    with SingleTickerProviderStateMixin {
  /// The controller that drives [_fade] animation.
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: PuzzleThemeAnimationDuration.questionLaunch,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 1, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = context.select((MslidePuzzleBloc bloc) => bloc.state.status);
    final notStarted = (status == mslidePuzzleStatus.notStarted);
    final loading = (status == mslidePuzzleStatus.loading);

    if (notStarted) {
      _controller.reset();
    } else if (loading) {
      _controller.forward();
    }

    return SizedBox.square(
      key: Key('mslide_question_${widget.question.index}'),
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
        child: widget.question.isWhitespace
            ? SizedBox()
            : Column(
                children: [
                  Expanded(
                    child: Center(
                      child: FadeTransition(
                        opacity: _fade,
                        child: Text(
                              widget.question.pair.questionStr,
                              textAlign: TextAlign.center,
                              style: PuzzleTextStyle.headline2.copyWith(
                                  fontSize: widget.tileFontSize,
                                  color: PuzzleColors.grey1),
                              semanticsLabel:
                                  'Question: ${widget.question.pair.questionStr}, index: ${widget.question.index}',
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
