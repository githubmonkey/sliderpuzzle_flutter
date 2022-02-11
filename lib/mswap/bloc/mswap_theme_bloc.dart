import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';

part 'mswap_theme_event.dart';
part 'mswap_theme_state.dart';

/// {@template mswap_theme_bloc}
/// Bloc responsible for the currently selected [MswapTheme].
/// {@endtemplate}
class MswapThemeBloc extends Bloc<MswapThemeEvent, MswapThemeState> {
  /// {@macro mswap_theme_bloc}
  MswapThemeBloc({required List<MswapTheme> themes})
      : super(MswapThemeState(themes: themes)) {
    on<MswapThemeChanged>(_onmswapThemeChanged);
  }

  void _onmswapThemeChanged(
    MswapThemeChanged event,
    Emitter<MswapThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
