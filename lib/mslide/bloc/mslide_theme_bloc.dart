import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';

part 'mslide_theme_event.dart';
part 'mslide_theme_state.dart';

/// {@template mslide_theme_bloc}
/// Bloc responsible for the currently selected [MslideTheme].
/// {@endtemplate}
class MslideThemeBloc extends Bloc<MslideThemeEvent, MslideThemeState> {
  /// {@macro mslide_theme_bloc}
  MslideThemeBloc({required List<MslideTheme> themes})
      : super(MslideThemeState(themes: themes)) {
    on<MslideThemeChanged>(_onmslideThemeChanged);
  }

  void _onmslideThemeChanged(
    MslideThemeChanged event,
    Emitter<MslideThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
