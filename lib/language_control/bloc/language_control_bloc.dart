// ignore_for_file: public_member_api_docs
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_control_event.dart';

part 'language_control_state.dart';

class LanguageControlBloc
    extends Bloc<LanguageControlEvent, LanguageControlState> {
  LanguageControlBloc() : super(const LanguageControlState(locale: null)) {
    on<LanguageToggled>(_onLanguageToggled);
    on<LanguageInit>(_onLanguageInit);
  }

  void _onLanguageToggled(
    LanguageToggled event,
    Emitter<LanguageControlState> emit,
  ) {
    if (state.locale?.languageCode != 'de') {
      emit(const LanguageControlState(locale: Locale('de')));
    } else {
      emit(const LanguageControlState(locale: Locale('en')));
    }
  }

  void _onLanguageInit(
    LanguageInit event,
    Emitter<LanguageControlState> emit,
  ) {
    if (state.locale?.languageCode != event.locale.languageCode) {
      emit(LanguageControlState(locale: event.locale));
    }
  }
}
