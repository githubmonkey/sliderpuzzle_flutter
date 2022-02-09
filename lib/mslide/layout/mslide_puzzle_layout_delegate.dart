import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/mslide/widgets/mslide_challenge_board.dart';
import 'package:very_good_slide_puzzle/mslide/widgets/mslide_question_tile.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';

abstract class _TileFontSize {
  static double small = 32;
  static double medium = 40;
  static double large = 54;
  static double xlarge = 50;
}

abstract class _QuestionFontSize {
  static double small = 18;
  static double medium = 28;
  static double large = 36;
  static double xlarge = 42;
}

/// {@template mslide_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [MslideTheme].
/// {@endtemplate}
class MslidePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro mslide_puzzle_layout_delegate}
  const MslidePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      xlarge: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => MslideStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const MslidePuzzleActionButton(),
          medium: (_, child) => const MslidePuzzleActionButton(),
          large: (_, __) => const SizedBox(),
          xlarge: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const MslideThemePicker(),
          medium: (_, child) => const MslideThemePicker(),
          large: (_, child) => const SizedBox(),
          xlarge: (_, child) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const ResponsiveGap(
          large: 130,
        ),
        const MslideCountdown(),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    // TODO: CLEAN UP
    return Positioned(
      bottom: 74,
      right: 50,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const MslideThemePicker(),
        xlarge: (_, child) => const MslideThemePicker(),
      ),
    );
  }

  @override
  Widget settingsBuilder(SettingsState state) {
    // TODO: clean up
    return Positioned(
      bottom: 74,
      right: 50,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) =>  const SettingsList(),
        xlarge: (_, child) =>  const SettingsList(),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles, List<Widget> questions) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const MslideTimer(),
            xlarge: (_, child) => const MslideTimer(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
              xlarge: 96,
            ),
            Stack(
              children: [
                MslideChallengeBoard(questions: questions, size: size),
                MslidePuzzleBoard(tiles: tiles, size: size),
              ],
            ),
            const ResponsiveGap(
              large: 96,
              xlarge: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => MslidePuzzleTile(
        tileFontSize: _TileFontSize.small,
        tile: tile,
        state: state,
      ),
      medium: (_, child) => MslidePuzzleTile(
        tileFontSize: _TileFontSize.medium,
        tile: tile,
        state: state,
      ),
      large: (_, child) => MslidePuzzleTile(
        tileFontSize: _TileFontSize.large,
        tile: tile,
        state: state,
      ),
      xlarge: (_, child) => MslidePuzzleTile(
        tileFontSize: _TileFontSize.xlarge,
        tile: tile,
        state: state,
      ),
    );
  }

  @override
  Widget questionBuilder(Question question, PuzzleState state) {
      return ResponsiveLayoutBuilder(
        small: (_, child) => MslideQuestionTile(
          tileFontSize: _QuestionFontSize.small,
          question: question,
        ),
        medium: (_, child) => MslideQuestionTile(
          tileFontSize: _QuestionFontSize.medium,
          question: question,
        ),
        large: (_, child) => MslideQuestionTile(
          tileFontSize: _QuestionFontSize.large,
          question: question,
        ),
        xlarge: (_, child) => MslideQuestionTile(
          tileFontSize: _QuestionFontSize.xlarge,
          question: question,
        ),
      );
    }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
