// ignore_for_file: public_member_api_docs

part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsChanged extends SettingsEvent {
  const SettingsChanged({required this.settings});

  final Settings settings;

  @override
  List<Object?> get props => [settings];
}

