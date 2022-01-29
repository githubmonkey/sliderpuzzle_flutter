// ignore_for_file: public_member_api_docs

part of 'mslide_theme_bloc.dart';

abstract class MslideThemeEvent extends Equatable {
  const MslideThemeEvent();
}

class MslideThemeChanged extends MslideThemeEvent {
  const MslideThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [MslideThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
