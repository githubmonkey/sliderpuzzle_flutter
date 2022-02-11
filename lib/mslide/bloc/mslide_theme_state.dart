// ignore_for_file: public_member_api_docs

part of 'mslide_theme_bloc.dart';

class MslideThemeState extends Equatable {
  const MslideThemeState({
    required this.themes,
    this.theme = const YellowMslideTheme(),
  });

  /// The list of all available [MslideTheme]s.
  final List<MslideTheme> themes;

  /// Currently selected [MslideTheme].
  final MslideTheme theme;

  @override
  List<Object> get props => [themes, theme];

  MslideThemeState copyWith({
    List<MslideTheme>? themes,
    MslideTheme? theme,
  }) {
    return MslideThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
