import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mswap/bloc/mswap_puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/themes/puzzle_theme_animations.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';

/// {@template mswap_puzzle_tile}
/// Displays the puzzle tile associated with [question]
/// based on the puzzle state.
/// {@endtemplate}
class MswapQuestionTile extends StatefulWidget {
  /// {@macro mswap_puzzle_tile}
  const MswapQuestionTile({
    Key? key,
    required this.question,
    required this.tileFontSize,
  }) : super(key: key);

  /// The tile to be displayed.
  final Question question;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  @override
  State<MswapQuestionTile> createState() => _MswapQuestionTileState();
}

/// The state of [MswapQuestionTile].
class _MswapQuestionTileState extends State<MswapQuestionTile>
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
    final status = context.select((MswapPuzzleBloc bloc) => bloc.state.status);
    final launchStage =
        context.select((MswapPuzzleBloc bloc) => bloc.state.launchStage);
    final hide = status == mswapPuzzleStatus.loading &&
        launchStage == LaunchStages.resetting;
    final reveal = status == mswapPuzzleStatus.started ||
        status == mswapPuzzleStatus.notStarted ||
        (status == mswapPuzzleStatus.loading &&
            launchStage == LaunchStages.showQuestions);

    final encoding =
        context.select((SettingsBloc bloc) => bloc.state.answerEncoding);

    if (hide) {
      _controller.reset();
    } else if (reveal) {
      _controller.forward();
    }

    final adjustedFontSize =
        encoding == AnswerEncoding.roman || encoding == AnswerEncoding.binary
            ? widget.tileFontSize * 0.7
            : widget.tileFontSize;

    final style = PuzzleTextStyle.headline2.copyWith(
      fontSize: adjustedFontSize,
      color: PuzzleColors.grey1,
    );

    return SizedBox.square(
      key: Key('mswap_question_${widget.question.index}'),
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
                      ? const SizedBox()
                      : RichText(
                          text: TextSpan(
                            text: widget.question.pair.left.toString(),
                            style: style,
                            children: <InlineSpan>[
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child:
                                    Text(' x ', style: PuzzleTextStyle.label),
                              ),
                              TextSpan(
                                text: widget.question.pair.right.toString(),
                                style: style,
                              ),
                            ],
                          ),
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
