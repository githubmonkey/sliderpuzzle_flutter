// ignore_for_file: public_member_api_docs

part of 'mswap_theme_bloc.dart';

class MswapThemeState extends Equatable {
  const MswapThemeState({
    required this.themes,
    this.theme = const GreenMswapTheme(),
  });

  /// The list of all available [MswapTheme]s.
  final List<MswapTheme> themes;

  /// Currently selected [MswapTheme].
  final MswapTheme theme;

  @override
  List<Object> get props => [themes, theme];

  MswapThemeState copyWith({
    List<MswapTheme>? themes,
    MswapTheme? theme,
  }) {
    return MswapThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
