import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/language_control/bloc/language_control_bloc.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template language_control}
/// Displays and allows to update the current language status of the puzzle.
/// {@endtemplate}
class LanguageControl extends StatelessWidget {
  /// {@macro language_control}
  const LanguageControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final locale =
        context.select((LanguageControlBloc bloc) => bloc.state.locale);
    final languageLabel = locale == const Locale('en') ? 'DE' : 'EN';

    return AnimatedSwitcher(
      duration: PuzzleThemeAnimationDuration.textStyle,
      child: Tooltip(
        key: Key(languageLabel),
        message: context.l10n.languageChangeTooltip,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            context.read<LanguageControlBloc>().add(const LanguageToggled());
          },
          child: Text(
            languageLabel,
            style: PuzzleTextStyle.headline5.copyWith(
              color: theme.menuActiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
