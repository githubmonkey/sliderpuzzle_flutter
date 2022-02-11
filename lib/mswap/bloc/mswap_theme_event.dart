// ignore_for_file: public_member_api_docs

part of 'mswap_theme_bloc.dart';

abstract class MswapThemeEvent extends Equatable {
  const MswapThemeEvent();
}

class MswapThemeChanged extends MswapThemeEvent {
  const MswapThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [MswapThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
