// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leaders_api/leaders_api.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsChanged>(_onSettingsChanged);
  }

  void _onSettingsChanged(
      SettingsChanged event,
      Emitter<SettingsState> emit,
      ) {

    emit(state.copyWith(settings: event.settings));
  }
}
