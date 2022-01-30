import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';

/// {@template blue_mslide_theme}
/// The blue mslide puzzle theme.
/// {@endtemplate}
class BlueMslideTheme extends MslideTheme {
  /// {@macro blue_mslide_theme}
  const BlueMslideTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.dashatarBlueDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.bluePrimary;

  @override
  Color get defaultColor => PuzzleColors.blue90;

  @override
  Color get buttonColor => PuzzleColors.blue50;

  @override
  Color get menuInactiveColor => PuzzleColors.blue50;

  @override
  Color get countdownColor => PuzzleColors.blue50;

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/blue_mslide_off.png';

  @override
  String get audioAsset => 'assets/audio/dumbbell.mp3';
}
