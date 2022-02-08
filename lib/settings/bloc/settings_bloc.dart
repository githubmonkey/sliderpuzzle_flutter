// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<BoardSizeChanged>(_onBoardSizeChanged);
    on<ElevenToTwentyChanged>(_onElevenToTwenty);
    on<AnswerEncodingChanged>(_onAnswerEncodingChanged);
  }

  void _onBoardSizeChanged(
    BoardSizeChanged event,
    Emitter<SettingsState> emit,
  ) {

    emit(state.copyWith(boardSize: event.boardSize));
  }

  void _onElevenToTwenty(
    ElevenToTwentyChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(elevenToTwenty: event.elevenToTwenty));
  }

  void _onAnswerEncodingChanged(
    AnswerEncodingChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(answerEncoding: event.answerEncoding));
  }
}
