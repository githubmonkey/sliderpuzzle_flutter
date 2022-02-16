import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/bloc/mslide_puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template mslide_puzzle_tile}
/// Displays the puzzle tile associated with [question]
/// based on the puzzle state.
/// {@endtemplate}
class MslideQuestionTile extends StatefulWidget {
  /// {@macro mslide_puzzle_tile}
  const MslideQuestionTile({
    Key? key,
    required this.question,
    required this.tileFontSize,
  }) : super(key: key);

  /// The tile to be displayed.
  final Question question;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  State<MslideQuestionTile> createState() => _MslideQuestionTileState();
}

/// The state of [MslideQuestionTile].
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
    final launchStage =
        context.select((MslidePuzzleBloc bloc) => bloc.state.launchStage);
    final hide = status == mslidePuzzleStatus.loading &&
        launchStage == LaunchStages.resetting;
    final reveal = status == mslidePuzzleStatus.started ||
        status == mslidePuzzleStatus.notStarted ||
        (status == mslidePuzzleStatus.loading &&
            launchStage == LaunchStages.showQuestions);

    if (hide) {
      _controller.reset();
    } else if (reveal) {
      _controller.forward();
    }

    return SizedBox.square(
      key: Key('mslide_question_${widget.question.index}'),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: PuzzleColors.white,
          border: Border.all(
            color: PuzzleColors.grey2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: widget.question.isWhitespace
                      ? const Text('')
                      : QuestionText(
                          pair: widget.question.pair,
                          tileFontSize: widget.tileFontSize,
                        ),
                ),
              ),
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
