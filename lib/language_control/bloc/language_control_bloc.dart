// ignore_for_file: public_member_api_docs
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_control_event.dart';

part 'language_control_state.dart';

class LanguageControlBloc
    extends Bloc<LanguageControlEvent, LanguageControlState> {

  LanguageControlBloc() : super(const LanguageControlState()) {
    on<LanguageToggled>(_onLanguageToggled);
  }

  void _onLanguageToggled(
    LanguageControlEvent event,
    Emitter<LanguageControlState> emit,
  ) {
    if (state.locale == const Locale('en')) {
      emit(const LanguageControlState(locale: Locale('de')));
    } else {
      emit(const LanguageControlState(locale: Locale('en')));
    }
  }
}
