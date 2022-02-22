// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';

/// Returns a new instance of [LocalizationHelper].
LocalizationHelper getLocalizationHelper() => LocalizationHelper();

/// A Localization-related utilities.
class LocalizationHelper {
  String localizedGame(BuildContext context, Game game) {
    switch (game) {
      case Game.multi:
        return context.l10n.settingsGameValueMulti;
      case Game.addition:
        return context.l10n.settingsGameValueAddition;
      case Game.hex:
        return context.l10n.settingsGameValueHex;
      case Game.binary:
        return context.l10n.settingsGameValueBinary;
      case Game.roman:
        return context.l10n.settingsGameValueRoman;
      case Game.noop:
      // This shouldn't be called in a game
        return 'not set';
    }
  }

  String localizedElevenToTwenty(BuildContext context, bool elevenToTwenty) {
    return elevenToTwenty
        ? context.l10n.settingsElevenToTwentyTrue
        : context.l10n.settingsElevenToTwentyFalse;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String localizedDurationLabel(BuildContext context, Duration duration) {
    return context.l10n.dashatarPuzzleDurationLabelText(
      duration.inHours.toString(),
      duration.inMinutes.remainder(60).toString(),
      duration.inSeconds.remainder(60).toString(),
    );
  }
}
