import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';

/// {@template yellow_mswap_theme}
/// The yellow mswap puzzle theme.
/// {@endtemplate}
class YellowMswapTheme extends MswapTheme {
  /// {@macro yellow_mswap_theme}
  const YellowMswapTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.dashatarYellowDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.yellowPrimary;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  Color get buttonColor => PuzzleColors.yellow50;

  @override
  Color get menuInactiveColor => PuzzleColors.yellow50;

  @override
  Color get countdownColor => PuzzleColors.yellow50;

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_dashatar_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';
}
