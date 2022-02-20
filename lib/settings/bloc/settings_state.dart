// ignore_for_file: public_member_api_docs

part of 'settings_bloc.dart';

// TODO(s): rename this, it's not longer encoding only
//enum AnswerEncoding { multi, addition, hex, binary, roman, noop }

class SettingsState extends Equatable {
  // Default settings
  const SettingsState({
    this.settings = const Settings(
      theme: 'Slide',
      boardSize: 4,
      game: Game.multi,
      elevenToTwenty: false,
    ),
  });

  final Settings settings;

  SettingsState copyWith({
    Settings? settings,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [settings];
}
