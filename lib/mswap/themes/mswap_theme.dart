import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template mswap_theme}
/// The mswap puzzle theme.
/// {@endtemplate}
abstract class MswapTheme extends PuzzleTheme {
  /// {@macro mswap_theme}
  const MswapTheme() : super();

  @override
  String get name => 'Swap';

  @override
  String localizedTitle(BuildContext context) => context.l10n.puzzleTitleMswap;

  @override
  String get summary => 'Focus on your math';

  @override
  String get instructions => 'Swap to solve';

  @override
  String get audioControlOnAsset =>
      'assets/images/audio_control/dashatar_on.png';

  @override
  bool get hasTimer => true;

  @override
  Color get nameColor => PuzzleColors.white;

  @override
  Color get titleColor => PuzzleColors.white;

  @override
  Color get hoverColor => PuzzleColors.black2;

  @override
  Color get pressedColor => PuzzleColors.white2;

  @override
  bool get isLogoColored => false;

  @override
  Color get menuActiveColor => PuzzleColors.white;

  @override
  Color get menuUnderlineColor => PuzzleColors.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate =>
      const MswapPuzzleLayoutDelegate();

  /// The semantics label of this theme.
  String semanticsLabel(BuildContext context);

  /// The text color of the countdown timer.
  Color get countdownColor;

  /// The path to the audio asset of this theme.
  String get audioAsset;

  @override
  List<Object?> get props => [
        name,
        hasTimer,
        nameColor,
        titleColor,
        backgroundColor,
        defaultColor,
        buttonColor,
        hoverColor,
        pressedColor,
        isLogoColored,
        menuActiveColor,
        menuUnderlineColor,
        menuInactiveColor,
        audioControlOnAsset,
        audioControlOffAsset,
        layoutDelegate,
        countdownColor,
        audioAsset,
      ];
}
